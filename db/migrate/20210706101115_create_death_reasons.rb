class CreateDeathReasons < ActiveRecord::Migration[6.1]
  def up
    create_table :death_reasons, comment: "Причины смерти" do |t|
      t.belongs_to :certificate, null: false, comment: "ссылка на свидетельство"
      t.belongs_to :diagnosis, null: false, comment: "код мкб-10"
      t.datetime :effective_time, comment: "период времени"
      t.timestamps
    end
  end

  def down
    drop_table :death_reasons
  end
end
