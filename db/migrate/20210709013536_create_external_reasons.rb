class CreateExternalReasons < ActiveRecord::Migration[6.1]
  def up
    create_table :external_reasons, comment: "Внешние причины смерти" do |t|
      t.belongs_to :ext_diagnosis, null: false, comment: "код мкб-10"
      t.datetime :effective_time, comment: "период времени"
      t.timestamps
    end
  end

  def down
    drop_table :external_reasons
  end
end
