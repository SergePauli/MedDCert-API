class NullFlavor < ApplicationRecord
  enum code: [:NI, :INV, :DER, :OTH, :NINF, :PINF, :UNC, :MSK, :NA, :UNK, :ASKU, :NAV, :NASK, :QS, :TRC]
  RU_NAMES = { NI: "нет информации", INV: "недопустимое значение", DER: "извлекаемое значение",
               OTH: "другое", NINF: "минус бесконечность", PINF: "плюс бесконечность",
               UNC: "кодирование не проводилось", MSK: "скрыто", NA: "неприменимо", UNK: "неизвестно",
               ASKU: "запрошено, но неизвестно", NAV: "временно недоступно", NASK: "не запрашивалось",
               QS: "достаточное количество", TRC: "трудноразличимо" }.freeze
  # For using in UniversalEnttityController or other models
  # Для использования в универсальном контроллере сущностей
  # и в других моделях
  def self.permitted_params
    [:id, :parent_guid, :parent_attr, :code, :_destroy]
  end
end
