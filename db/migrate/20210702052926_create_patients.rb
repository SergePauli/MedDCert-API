class CreatePatients < ActiveRecord::Migration[6.1]
  def change
    create_table :patients do |t|
      t.uuid :person_id, index: true, comment: "person ID"
      t.uuid :identitie_id, index: true, comment: "identitie ID"
      t.uuid :addr_id, index: true, comment: "адрес"
      t.integer :addr_type, :limit => 1, comment: "тип адреса"
      t.integer :gender, :limit => 1, comment: "Пол"
      t.date :birthTime, comment: "дата рождения nullFlavor: ASKU и UNK"
      t.uuid :providerOrganization, comment: "Организация, констатировавшая факт смерти"
      t.uuid :guid, index: true, null: false, default: -> { "gen_random_uuid()" }, unique: true
      t.timestamps
    end
  end
end
