class NullFlavor < ApplicationRecord
  enum value: [:NI, :INV, :DER, :OTH, :NINF, :PINF, :UNC, :MSK, :NA, :UNK, :ASKU, :NAV, :NASK, :QS, :TRC]
  self.RU_NAMES = { NI: "Нет информации", INV: "Недопустимое значение", DER: "Извлекаемое значение",
                    OTH: "Другое", NINF: "Минус бесконечность", PINF: "Плюс бесконечность",
                    UNC: "Кодирование не проводилось", MSK: "Скрыто", NA: "Неприменимо", UNK: "Неизвестно",
                    ASKU: "Запрошено, но неизвестно", NAV: "Временно недоступно", NASK: "Не запрашивалось",
                    QS: "Достаточное количество", TRC: "Трудноразличимо" }.freeze
end
