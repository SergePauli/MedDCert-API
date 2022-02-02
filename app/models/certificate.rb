# Модель данных свидетельства (Main data model)
class Certificate < ApplicationRecord
  # audit needed
  def self.trackable?
    true
  end

  def self.cert_types
    ["не определенное", "окончательное", "предварительное",
     "взамен предварительного", "взамен окончательного"]
  end

  after_initialize do |cert|
    # Check if certificate is new
    if cert.number&.length === 2
      minNumber = "1#{Date.today.to_s[2..3]}#{cert.number}0000"
      maxNumber = "1#{Date.today.to_s[2..3]}#{cert.number}9999"
      prevNumber = Certificate.where("number > ?", minNumber).where("number < ?", maxNumber).maximum(:number)
      cert.number = prevNumber === nil ? "1#{Date.today.to_s[2..3]}#{cert.number}0001" : (prevNumber.to_i + 1).to_s
    end
  end

  #-------------------------Связи-------------------------------------------

  # Связь с записью пациента
  belongs_to :patient, primary_key: "id", foreign_key: "patient_id", autosave: true
  accepts_nested_attributes_for :patient
  # Связь с записью данных подписи заполнившего свидетельство
  has_one :author, foreign_key: "certificate_id", primary_key: "id", class_name: "Author", autosave: true, dependent: :destroy
  accepts_nested_attributes_for :author, allow_destroy: true
  # Связь с записью данных подписи гл.врача
  has_one :legal_authenticator, foreign_key: "certificate_id", primary_key: "id", class_name: "LegalAuthenticator", autosave: true, dependent: :destroy
  accepts_nested_attributes_for :legal_authenticator, allow_destroy: true
  # Связь с записью данных подписи заверившего свидетельство
  has_one :audithor, foreign_key: "certificate_id", primary_key: "id", class_name: "Audithor", autosave: true, dependent: :destroy
  accepts_nested_attributes_for :audithor, allow_destroy: true
  # Связь с записью данных медорганизации
  belongs_to :custodian, class_name: "Organization", foreign_key: "custodian_id"
  # Связь с записью данных причины а)
  has_one :a_reason, foreign_key: "certificate_id", primary_key: "id", class_name: "AReason", autosave: true, dependent: :destroy
  accepts_nested_attributes_for :a_reason, allow_destroy: true
  # Связь с записью данных причины б)
  has_one :b_reason, foreign_key: "certificate_id", primary_key: "id", class_name: "BReason", autosave: true, dependent: :destroy
  accepts_nested_attributes_for :b_reason, allow_destroy: true
  # Связь с записью данных причины в)
  has_one :c_reason, foreign_key: "certificate_id", primary_key: "id", class_name: "CReason", autosave: true, dependent: :destroy
  accepts_nested_attributes_for :c_reason, allow_destroy: true
  # Связь с записью данных внешней причины г)
  has_one :d_reason, primary_key: "id", foreign_key: "certificate_id", class_name: "ExternalReason", autosave: true, dependent: :destroy
  accepts_nested_attributes_for :d_reason, allow_destroy: true

  has_one :participant, primary_key: "id", foreign_key: "certificate_id", autosave: true, dependent: :destroy
  accepts_nested_attributes_for :participant

  # Связь с записью более нового свидетельства
  has_one :latest_one, primary_key: "number", class_name: "Certificate", foreign_key: "number_prev"

  # ----дочерние записи--------

  # Связь с записью адреса места смерти
  has_one :death_addr, primary_key: "guid", class_name: "Address", foreign_key: "parent_guid", autosave: true, dependent: :destroy
  accepts_nested_attributes_for :death_addr, allow_destroy: true

  # Заполнители причин отсутствия
  has_many :null_flavors, class_name: "NullFlavor", primary_key: "guid", foreign_key: "parent_guid", dependent: :destroy
  accepts_nested_attributes_for :null_flavors, allow_destroy: true

  # инфо по детям до года
  has_one :child_info, class_name: "ChildInfo", primary_key: "id", foreign_key: "certificate_id", dependent: :destroy
  accepts_nested_attributes_for :child_info, allow_destroy: true

  # Прочие состояния и диагнозы, способствовавшие смерти
  has_many :death_reasons, class_name: "OtherReason", primary_key: "id", foreign_key: "certificate_id", dependent: :destroy
  accepts_nested_attributes_for :death_reasons, allow_destroy: true

  def to_s
    "Свидетельство[#{id}] СЕРИЯ #{series} № #{number} #{!issue_date.blank? ? "от " + issue_date.strftime("%d.%m.%Y") : ""} #{Certificate.cert_types[cert_type]} на #{patient.person ? patient.person.name : "неидентифицированого"}"
  end

  # For using in UniversalEnttityController or other models
  # Для использования в универсальном контроллере сущностей
  def self.permitted_params
    [:id, :guid, :number, :series, :issue_date, :cert_type, :policy_OMS, :death_area_type, :life_area_type,
     :death_datetime, :death_year, :death_place, :marital_status, :education_level,
     :social_status, :death_kind, :ext_reason_time, :ext_reason_description, :traffic_accident,
     :established_medic, :basis_determining, :reason_ACME, :pregnancy_connection,
     :custodian_id,
     a_reason_attributes: DeathReason.permitted_params,
     b_reason_attributes: DeathReason.permitted_params,
     c_reason_attributes: DeathReason.permitted_params,
     d_reason_attributes: ExternalReason.permitted_params,
     death_reasons_attributes: OtherReason.permitted_params,
     child_info_attributes: ChildInfo.permitted_params,
     author_attributes: Authenticator.permitted_params,
     audithor_attributes: Authenticator.permitted_params,
     legal_authenticator_attributes: Authenticator.permitted_params,
     death_addr_attributes: Address.permitted_params,
     patient_attributes: Patient.permitted_params,
     null_flavors_attributes: NullFlavor.permitted_params]
  end
end
