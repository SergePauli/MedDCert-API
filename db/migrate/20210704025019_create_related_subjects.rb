class CreateRelatedSubjects < ActiveRecord::Migration[6.1]
  def change
    create_table :related_subjects, primary_key: "id", id: :uuid, default: -> { "gen_random_uuid()" }, comment: "элементы relatedSubject (данные матери ребенка до года)" do |t|
      t.integer :family_connection, limit: 1, null: false, default: 1, comment: "родственик (мать) 1.2.643.5.1.13.13.99.2.14"
      t.belongs_to :addr, null: false, comment: "ссылка на адрес"
      t.belongs_to :person_name, null: false, comment: "ссылка на ФИО-обязательна"
      t.date :birthTime, comment: "дата рождения, @nullFlavor: UNK"
      t.timestamps
    end
  end
end
