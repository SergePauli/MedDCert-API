class CreateExternalReasons < ActiveRecord::Migration[6.1]
  def change
    create_table :external_reasons, primary_key: "id", id: :string, comment: "Внешние причины смерти" do |t|
      t.belongs_to :certificate, null: false, comment: "ссылка на свидетельство"
      t.belongs_to :ext_diagnosis, null: false, comment: "код мкб-10"
      t.datetime :effective_time, comment: "период времени"
      t.timestamps
    end
  end
end
