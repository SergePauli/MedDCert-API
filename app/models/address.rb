class Address < ApplicationRecord
  has_many :null_flavors, class_name: "NullFlavor", primary_key: "id", foreign_key: "parent_guid"
  accepts_nested_attributes_for :null_flavors, allow_destroy: true
  # For using in UniversalEnttityController or other models
  # Для использования в универсальном контроллере сущностей
  # и в других моделях
  def self.permitted_params
    [:id, :state, :streetAddressLine, :aoGUID, :houseGUID, :postalCode,
     :code, :parent_guid, :actual, :house_number, :struct_number, :building_number,
     :flat_number, null_flavors_attributes: NullFlavor.permitted_params]
  end
end
