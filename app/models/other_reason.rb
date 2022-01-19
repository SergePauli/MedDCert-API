class OtherReason < DeathReason
  # Процедуры и операции
  has_many :procedures, class_name: "Procedure", primary_key: "id", foreign_key: "death_reason_id", dependent: :destroy
  accepts_nested_attributes_for :procedures, allow_destroy: true

  # For using in UniversalEnttityController or other models
  # Для использования в универсальном контроллере сущностей
  def self.permitted_params
    [:id, :guid, :diagnosis_id, :effective_time, :_destroy, procedures_attributes: Procedure.permitted_params,
                                                            null_flavors_attributes: NullFlavor.permitted_params]
  end
end
