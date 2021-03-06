class Patient < NullFlavorRecord
  # by default audit not needed
  def self.trackable?
    false
  end
  #enum addr_type: { "Адрес по месту жительства (постоянной регистрации)": 1, "Адрес по месту пребывания (временной #регистрации)": 2, "Адрес фактического проживания (пребывания)": 3, "Адрес места учебы/работы": 4 }
  # Связь с записью данных медорганизации
  belongs_to :organization
  # Связь с записью ДУЛ
  has_one :identity, primary_key: "guid", class_name: "Identity", foreign_key: "parent_guid", autosave: true, dependent: :destroy
  accepts_nested_attributes_for :identity, allow_destroy: true
  # Связь с записью персональных данных
  belongs_to :person, optional: true, autosave: true
  accepts_nested_attributes_for :person

  # Заполнители причин отсутствия
  has_many :null_flavors, class_name: "NullFlavor", primary_key: "guid", foreign_key: "parent_guid", dependent: :destroy
  accepts_nested_attributes_for :null_flavors, allow_destroy: true

  # For using in UniversalEnttityController or other models
  # Для использования в универсальном контроллере сущностей
  # и в других моделях
  def self.permitted_params
    [:id, :guid, :organization_id, :person_id, :addr_type, :gender, :birth_date, :birth_year,
     identity_attributes: Identity.permitted_params,
     person_attributes: Person.permitted_params,
     null_flavors_attributes: NullFlavor.permitted_params]
  end
end
