class DeathReason < ApplicationRecord
  #-------------------------Связи-------------------------------------------

  # Связь с диагнозом МКБ10
  belongs_to :diagnosis

  # Заполнители причин отсутствия
  has_many :null_flavors, class_name: "NullFlavor", primary_key: "guid", foreign_key: "parent_guid", dependent: :destroy
  accepts_nested_attributes_for :null_flavors, allow_destroy: true

  # Унифицированый вывод расшифровки кода МКБ10 для всех причин
  def diagnosis_name
    diagnosis.s_name
  end

  # Период времени
  def terms_to_s
    result = ""
    result += "#{years} года " if !years.blank? && years < 5
    result += "#{years} лет " if !years.blank? && years > 4
    result += "#{months} мес. " if !months.blank?
    result += "#{weeks} нед. " if !weeks.blank?
    result += "#{days} дн. " if !days.blank?
    result += "#{hours} ч. " if !hours.blank?
    result += "#{minutes} мин. " if !minutes.blank?
    return result
  end

  # For using in UniversalEnttityController or other models
  # Для использования в универсальном контроллере сущностей
  def self.permitted_params
    [:id, :guid, :diagnosis_id, :effective_time, :years, :months,
     :weeks, :days, :hours, :minutes, :_destroy, null_flavors_attributes: NullFlavor.permitted_params]
  end
end
