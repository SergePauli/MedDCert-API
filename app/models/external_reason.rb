class ExternalReason < ApplicationRecord
  # Связь с диагнозом МКБ10
  belongs_to :ext_diagnosis
  # Заполнители причин отсутствия
  has_many :null_flavors, class_name: "NullFlavor", primary_key: "guid", foreign_key: "parent_guid", dependent: :destroy
  accepts_nested_attributes_for :null_flavors, allow_destroy: true

  # For using in UniversalEnttityController or other models
  # Для использования в универсальном контроллере сущностей
  def self.permitted_params
    [:id, :ext_diagnosis_id, :effective_time, :years, :months,
     :weeks, :days, :hours, :minutes, :_destroy,
     null_flavors_attributes: NullFlavor.permitted_params]
  end
end
