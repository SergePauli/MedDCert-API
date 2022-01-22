class CreateExternalReasons < ActiveRecord::Migration[6.1]
  def up
    create_table :external_reasons, comment: "Внешние причины смерти" do |t|
      t.belongs_to :certificate, class_name: "Certificate"
      t.belongs_to :ext_diagnosis, null: false, comment: "код мкб-10"
      t.datetime :effective_time, comment: "период времени"
      t.uuid :guid, unique: true, null: false, default: -> { "gen_random_uuid()" }
      t.timestamps
    end
  end

  def down
    drop_table :external_reasons
  end
end
