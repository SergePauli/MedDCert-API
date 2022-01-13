class RelatedSubject < PersonRecord
  # Связь с записью адреса матери
  has_one :addr, primary_key: "guid", class_name: "Address", foreign_key: "parent_guid", autosave: true, dependent: :destroy
  accepts_nested_attributes_for :addr, allow_destroy: true

  # ----дочерние записи--------

  # Заполнители причин отсутствия
  has_many :null_flavors, class_name: "NullFlavor", primary_key: "guid", foreign_key: "parent_guid", dependent: :destroy
  accepts_nested_attributes_for :null_flavors, allow_destroy: true

  def self.permitted_params
    [:family_connection, :birthTime, :_destroy, null_flavors_attributes: NullFlavor.permitted_params] | PersonRecord.permitted_params
  end
end
