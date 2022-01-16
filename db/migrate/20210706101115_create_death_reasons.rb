class CreateDeathReasons < ActiveRecord::Migration[6.1]
  def up
    create_table :death_reasons, comment: "Причины смерти" do |t|
      t.string :type, index: true, comment: "тип причины, обеспечение STI"
      t.belongs_to :certificate, index: true, comment: "ссылка на свидетельство"
      t.belongs_to :diagnosis, null: false, comment: "код мкб-10"
      t.datetime :effective_time, comment: "период времени"
      t.uuid :guid, unique: true, null: false, default: -> { "gen_random_uuid()" }
      t.timestamps
    end
  end

  def down
    drop_table :death_reasons
  end
end
