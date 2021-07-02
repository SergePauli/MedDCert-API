class CreatePatients < ActiveRecord::Migration[6.1]
  def change
    create_table :patientRoles, primary_key: "id", id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.uuid :patient, comment: "person ID"
      t.uuid :addr, comment: "адрес"
      t.integer :addr_type, :limit => 1, comment: "тип адреса"
      t.integer :administrativeGenderCode, :limit => 1, comment: "Пол"
      t.date :birthTime, comment: "дата рождения"
      t.uuid :providerOrganization, comment: "Организация, констатировавшая факт смерти"
      t.uuid :parent, comment: "ClinicalDocument ID"
      t.timestamps
    end
  end
end
