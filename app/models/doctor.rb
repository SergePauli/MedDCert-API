# Модель данных участника документооборота
class Doctor < ActiveRecord::Base
  #  audit needed
  def self.trackable?
    true
  end

  belongs_to :position
  belongs_to :organization
  belongs_to :person, primary_key: "id", foreign_key: "person_id"

  has_many :null_flavors, class_name: "NullFlavor", primary_key: "guid", foreign_key: "parent_guid"

  accepts_nested_attributes_for :null_flavors, reject_if: ->(attributes) { attributes["parent_attr"].blank? || attributes["code"].blank? }, allow_destroy: true
  accepts_nested_attributes_for :person

  validates_associated :position
  validates_associated :organization
  #validates_associated :person
  after_initialize do |doctor|
    if doctor.person.id == nil && doctor.person
      exist_person = Person.where(SNILS: doctor.person.SNILS).first
      if exist_person
        exist_person.contacts = doctor.person.contacts if exist_person.contacts.blank? && doctor.person.contacts
        exist_person.address = doctor.person.address if exist_person.address.blank? && doctor.person.address
        doctor.person.save if (exist_person.contacts.blank? && doctor.person.contacts) || (exist_person.address.blank? && doctor.person.address)
        doctor.person = exist_person
      end
    end
  end

  def to_s
    "Врач id #{id} #{person.SNILS} #{person.name} #{position.name}"
  end

  # For using in UniversalEnttityController or other models
  # Для использования в универсальном контроллере сущностей
  # и в других моделях
  def self.permitted_params
    [:id, :guid, :organization_id, :position_id, person_attributes: Person.permitted_params,
                                                 null_flavors_attributes: NullFlavor.permitted_params]
  end
end
