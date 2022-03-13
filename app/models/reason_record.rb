# абстрактная модель всех причин смерти
# общие и дефолтные методы для всех наследников класса
class ReasonRecord < NullFlavorRecord
  self.abstract_class = true

  # Общий метод вывода расшифровки кода МКБ10 для всех причин
  # как внешних, так и внутрених
  def diagnosis_name
    diagnosis.s_name
  end

  # Период времени для рендеринга распечатки
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

  # проверяет, внесено ли время между началом состояния и смертью
  def is_effective_time?
    !(years.blank? && months.blank? && days.blank? && hours.blank? && minutes.blank?)
  end

  # возвращает effective_time в нужном для CDA формате:
  # "YYYYMMDD[HHMM[SS]+|-ZZZZ]"
  def fmt_effective_time(death_time)
    start_time = death_time
    start_time = start_time - (years).years if !years.blank?
    start_time = start_time - (months).months if !months.blank?
    start_time = start_time - (weeks).weeks if !weeks.blank?
    start_time = start_time - (days).days if !days.blank?
    start_time = start_time - (hours).hours if !hours.blank?
    start_time = start_time - (minutes).minutes if !minutes.blank?
    if hours || minutes
      time_zone = DateTime.now.to_s.slice(-6, 6).gsub(":", "")
      return start_time.strftime("%Y%m%d%k%M") + time_zone
    else
      return start_time.strftime("%Y%m%d%k%M")
    end
  end
end
