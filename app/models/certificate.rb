# Модель данных свидетельства (Main data model)
class Certificate < ApplicationRecord
  # audit needed
  def self.trackable?
    true
  end

  #-------------------------Связи-------------------------------------------

  # Связь с записью пациента
  belongs_to :patient, primary_key: "id", foreign_key: "patient_id", autosave: true, dependent: :destroy
  accepts_nested_attributes_for :patient
  # Связь с записью данных подписи заполнившего свидетельство
  belongs_to :author, primary_key: "id", autosave: true, dependent: :destroy
  accepts_nested_attributes_for :author, allow_destroy: true
  # Связь с записью данных подписи гл.врача
  belongs_to :legal_authenticator, primary_key: "id", autosave: true, dependent: :destroy
  accepts_nested_attributes_for :legal_authenticator, allow_destroy: true
  # Связь с записью данных подписи заверившего свидетельство
  belongs_to :authenticator, primary_key: "id", autosave: true, dependent: :destroy
  accepts_nested_attributes_for :authenticator, allow_destroy: true
  # Связь с записью данных медорганизации
  belongs_to :custodian, primary_key: "id"
  # Связь с записью адреса места смерти
  belongs_to :death_addr, primary_key: "id", foreign_key: "death_addr_id", autosave: true, dependent: :destroy
  accepts_nested_attributes_for :death_addr, allow_destroy: true
  # Связь с записью данных причины а)
  belongs_to :a_reason, autosave: true, dependent: :destroy
  accepts_nested_attributes_for :a_reason, allow_destroy: true
  # Связь с записью данных причины б)
  belongs_to :b_reason, autosave: true, dependent: :destroy
  accepts_nested_attributes_for :b_reason, allow_destroy: true
  # Связь с записью данных причины в)
  belongs_to :c_reason, autosave: true, dependent: :destroy
  accepts_nested_attributes_for :c_reason, allow_destroy: true
  # Связь с записью данных внешней причины г)
  belongs_to :d_reason, class_name: "ExternalReason", autosave: true, dependent: :destroy
  accepts_nested_attributes_for :d_reason, allow_destroy: true

  # ----дочерние записи--------

  # Заполнители причин отсутствия
  has_many :null_flavors, class_name: "NullFlavor", primary_key: "guid", foreign_key: "parent_guid", dependent: :destroy
  accepts_nested_attributes_for :null_flavors, allow_destroy: true

  # инфо по детям до года
  has_one :child_info, class_name: "ChildInfo", primary_key: "id", foreign_key: "certificate_id", dependent: :destroy
  accepts_nested_attributes_for :child_info, allow_destroy: true

  # Прочие состояния и диагнозы, способствовавшие смерти
  has_many :death_reasons, class_name: "DeathReason", primary_key: "id", foreign_key: "certificate_id", dependent: :destroy
  accepts_nested_attributes_for :death_reasons, allow_destroy: true

  def to_s
    "Свидетельство[#{id}] #{series}_#{number} #{patient.person.name}"
  end

  # For using in UniversalEnttityController or other models
  # Для использования в универсальном контроллере сущностей
  def self.permitted_params
    [:id, :guid, :eff_time, :cert_type, :policy_OMS, :lifeAreaType, :deathAreaType,
     :death_datetime, :death_year, :death_place, :marital_status, :education_level,
     :social_status, :death_kind, :ext_reason_time, :ext_reason_description,
     :established_medic, :basis_determining, :reason_ACME, :pregnancy_connection,
     :custodian_id,
     a_reason_attributes: DeathReason.permitted_params,
     b_reason_attributes: DeathReason.permitted_params,
     c_reason_attributes: DeathReason.permitted_params,
     d_reason_attributes: ExternalReason.permitted_params,
     death_reasons_attributes: DeathReason.permitted_params,
     child_info_attributes: ChildInfo.permitted_params,
     author_attributes: Authenticator.permitted_params,
     authenticator_attributes: Authenticator.permitted_params,
     legal_authenticator_attributes: Authenticator.permitted_params,
     death_addr_attributes: Address.permitted_params,
     patient_attributes: Patient.permitted_params,
     null_flavors_attributes: NullFlavor.permitted_params]
  end
end
