class CreateDoctors < ActiveRecord::Migration[6.1]
  def up
    create_table :doctors do |t|
      t.uuid :person_id, index: true, comment: "person ID"
      t.belongs_to :organization, index: true, comment: "Медорганизаия"
      t.belongs_to :position, comment: "должность"
      t.uuid :guid, index: true, null: false, default: -> { "gen_random_uuid()" }, unique: true
      t.timestamps
    end
  end

  def down
    drop_table :doctors
  end
end
