class Identity < NullFlavorRecord
  # Связь с записью типа документа УЛ
  belongs_to :identity_card_type
  # Заполнители причин отсутствия
  has_many :null_flavors, class_name: "NullFlavor", primary_key: "id", foreign_key: "parent_guid", dependent: :destroy
  accepts_nested_attributes_for :null_flavors, allow_destroy: true

  # формирует строковое представление для печати
  def identity_text
    result = identity_card_type.name
    result += " " + series if series
    result += " " + number if number
    result += " " + issueOrgName if issueOrgName
  end

  # For using in UniversalEnttityController or other models
  # Для использования в универсальном контроллере сущностей
  # и в других моделях
  def self.permitted_params
    [:id, :identity_card_type_id, :series, :number, :issueOrgName, :issueOrgCode,
     :issueDate, :parent_guid, :_destroy,
     null_flavors_attributes: NullFlavor.permitted_params]
  end
end
