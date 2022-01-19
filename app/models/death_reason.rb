class DeathReason < ApplicationRecord
  #-------------------------Связи-------------------------------------------

  # Связь с диагнозом МКБ10
  belongs_to :diagnosis

  # Заполнители причин отсутствия
  has_many :null_flavors, class_name: "NullFlavor", primary_key: "guid", foreign_key: "parent_guid", dependent: :destroy
  accepts_nested_attributes_for :null_flavors, allow_destroy: true

  # For using in UniversalEnttityController or other models
  # Для использования в универсальном контроллере сущностей
  def self.permitted_params
    [:id, :guid, :diagnosis_id, :effective_time, :_destroy, null_flavors_attributes: NullFlavor.permitted_params]
  end
end
