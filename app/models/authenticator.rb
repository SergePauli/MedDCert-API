class Authenticator < ApplicationRecord
  # Связь с записью данных медработника
  belongs_to :doctor

  # For using in UniversalEnttityController or other models
  # Для использования в универсальном контроллере сущностей
  def self.permitted_params
    [:id, :time, :doctor_id, :_destroy]
  end
end
