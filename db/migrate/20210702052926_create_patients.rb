class CreatePatients < ActiveRecord::Migration[6.1]
  def change
    create_table :patients do |t|
      t.uuid :person_id, index: true, comment: "person ID"
      t.uuid :identitie_id, index: true, comment: "identitie ID"
      t.uuid :addr_id, index: true, comment: "адрес по документу"
      t.integer :addr_type, limit: 1, comment: "enum тип адреса(проживания, регистрации)"
      t.integer :gender, limit: 1, comment: "пол пациента"
      t.date :birth_date, comment: "дата рождения nullFlavor: ASKU и UNK"
      t.integer :birth_year, limit: 2, comment: "год рождения - если неизвестен месяц"
      t.integer :birth_month, limit: 1, comment: "месяц рождения - если неизвестен день"
      t.uuid :provider_organization, comment: "Организация, констатировавшая факт смерти"
      t.uuid :guid, index: true, null: false, default: -> { "gen_random_uuid()" }, unique: true
      t.timestamps
    end
  end
end
