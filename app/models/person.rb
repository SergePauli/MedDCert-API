class Person < PersonRecord
  has_one :address, -> { where(actual: true) }, class_name: "Address", primary_key: :id, foreign_key: :parent_guid
  has_many :contacts, class_name: "Contact", primary_key: :id, foreign_key: :parent_guid
  # Заполнители причин отсутствия
  has_many :null_flavors, class_name: "NullFlavor", primary_key: "id", foreign_key: "parent_guid", dependent: :destroy
  accepts_nested_attributes_for :null_flavors, allow_destroy: true

  accepts_nested_attributes_for :contacts, allow_destroy: true
  accepts_nested_attributes_for :address, allow_destroy: true

  def to_s
    "#{SNILS} #{person_name.name} #{addres.streetAddressLine}"
  end

  def self.permitted_params
    [:id, :SNILS, null_flavors_attributes: NullFlavor.permitted_params,
                  contacts_attributes: Contact.permitted_params,
                  address_attributes: Address.permitted_params] | PersonRecord.permitted_params
  end
end
