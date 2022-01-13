class ExternalReason < ApplicationRecord
  # Связь с диагнозом МКБ10
  belongs_to :ext_diagnosis

  # For using in UniversalEnttityController or other models
  # Для использования в универсальном контроллере сущностей
  def self.permitted_params
    [:id, :ext_diagnosis_id, :effective_time, :_destroy,
     null_flavors_attributes: NullFlavor.permitted_params]
  end
end
