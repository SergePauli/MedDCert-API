# this module for using NSI allowed values according CDA realese 2 level 3
# модуль коснстант для отображения значений
# реестра справочников НСИ минздрава РФ
module NsiConstant
  # разрешенные отображаемые значения для типа местности
  AREA_TYPES = ["городская", "сельская"].freeze
  # разрешенные значения для пола
  GENDERS = ["мужской", "женский"].freeze
  # разрешенные значения для пункта "смерть наступила.."
  DEATH_PLACES = ["на месте происшествия", "в машине скорой помощи", "в стационаре", "дома", "в образовательной организации", "в другом месте"].freeze
  # разрешенные значения для пункта "смерть произошла.."
  DEATH_KINDS = ["от заболевания", "несчастного случая: не связанного с производством", "связанного с производством", "убийства", "самоубийства", "в ходе действий: военных", "террористических", "род смерти не установлен"].freeze
  # разрешенные значения для пункта "причины смерти установлены.."
  ESTABLISHED_MEDIC = ["врачом, только установившим смерть", " лечащим врачом", "фельдшером, акушеркой", "врачом-патологоанатомом", "врачом - судебно-медицинским экспертом"].freeze

  MARITAL_STATUSES = {
    4 => "состоял(а) в зарегистрированном браке",
    5 => "не состоял(а) в зарегистрированном браке",
    3 => "неизвестно",
  }.freeze
  EDUCATION_LEVELS = {
    1 => "профессиональное: высшее",
    2 => "профессиональное: неполное высшее",
    3 => "профессиональное: среднее профессиональное",
    5 => "общее: среднее",
    6 => "общее: основное",
    7 => "общее: начальное",
    10 => "общее: дошкольное",
    11 => "не имеет начального образования",
    9 => "неизвестно",
  }.freeze
  SOCIAL_STATUSES = {
    4 => "студент(ка)",
    5 => "работал(а)",
    6 => "проходил(а) военную или приравненную к ней службу",
    7 => "пенсионер(ка)",
    8 => "не работал(а)",
    10 => "прочие",
    22 => "неизвестно",
  }.freeze
end
