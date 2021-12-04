class NullFlavor < ApplicationRecord
  enum code: [:NI, :INV, :DER, :OTH, :NINF, :PINF, :UNC, :MSK, :NA, :UNK, :ASKU, :NAV, :NASK, :QS, :TRC]
  RU_NAMES = { NI: "Нет информации", INV: "Недопустимое значение", DER: "Извлекаемое значение",
               OTH: "Другое", NINF: "Минус бесконечность", PINF: "Плюс бесконечность",
               UNC: "Кодирование не проводилось", MSK: "Скрыто", NA: "Неприменимо", UNK: "Неизвестно",
               ASKU: "Запрошено, но неизвестно", NAV: "Временно недоступно", NASK: "Не запрашивалось",
               QS: "Достаточное количество", TRC: "Трудноразличимо" }.freeze
  # For using in UniversalEnttityController or other models
  # Для использования в универсальном контроллере сущностей
  # и в других моделях
  def self.permitted_params
    [:id, :parent_guid, :parent_attr, :code]
  end
end
