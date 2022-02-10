class OtherReason < DeathReason
  # Процедуры и операции
  has_many :procedures, class_name: "Procedure", primary_key: "id", foreign_key: "death_reason_id", dependent: :destroy
  accepts_nested_attributes_for :procedures, allow_destroy: true

  # Унифицированый вывод расшифровки кода МКБ10 для всех причин
  def diagnosis_name
    result = diagnosis.s_name
    result += procNames if procedures.size > 0
  end

  # генерируем строку хирургических операций(процедур)
  def procNames
    result = " "
    procedures.each do |proc|
      result += proc.text_value || proc.medical_serv.name
      result += " от " + proc.timeStr if proc.effective_time
      result += "; "
    end
    return result
  end

  # For using in UniversalEnttityController or other models
  # Для использования в универсальном контроллере сущностей
  def self.permitted_params
    DeathReason.permitted_params | [procedures_attributes: Procedure.permitted_params]
  end
end
