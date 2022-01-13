class Procedure < ApplicationRecord
  #-------------------------Связи-----------------------------------------

  # Связь с медуслугой
  belongs_to :medical_serv

  # Заполнители причин отсутствия
  has_many :null_flavors, class_name: "NullFlavor", primary_key: "guid", foreign_key: "parent_guid", dependent: :destroy
  accepts_nested_attributes_for :null_flavors, allow_destroy: true

  # For using in UniversalEnttityController or other models
  # Для использования в универсальном контроллере сущностей
  def self.permitted_params
    [:id, :guid, :medical_serv_id, :effective_time, :_destroy,
     null_flavors_attributes: NullFlavor.permitted_params]
  end
end
