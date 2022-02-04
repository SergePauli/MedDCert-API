class Participant < ApplicationRecord
  # Связь с записью ДУЛ
  has_one :identity, primary_key: "person_id", class_name: "Identity", foreign_key: "parent_guid", autosave: true, dependent: :destroy
  accepts_nested_attributes_for :identity, allow_destroy: true
  # Связь с записью персональных данных
  belongs_to :person, autosave: true
  accepts_nested_attributes_for :person
  # For using in UniversalEnttityController or other models
  # Для использования в универсальном контроллере сущностей
  # и в других моделях
  def self.permitted_params
    [:id, :receipt_date, :description, :original,
     identity_attributes: Identity.permitted_params,
     person_attributes: Person.permitted_params]
  end
end
