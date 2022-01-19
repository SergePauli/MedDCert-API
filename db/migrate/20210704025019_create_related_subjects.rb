class CreateRelatedSubjects < ActiveRecord::Migration[6.1]
  def up
    create_table :related_subjects, comment: "элементы relatedSubject (данные матери ребенка до года)" do |t|
      t.belongs_to :certificate, index: true, unique: true
      t.integer :family_connection, limit: 1, null: false, default: 1, comment: "родственик (мать) 1.2.643.5.1.13.13.99.2.14"
      t.belongs_to :person_name, null: false, comment: "ссылка на ФИО-обязательна"
      t.date :birthTime, comment: "дата рождения, @nullFlavor: UNK"
      t.uuid :guid, index: true, null: false, default: -> { "gen_random_uuid()" }, unique: true
      t.timestamps
    end
  end

  def down
    drop_table :related_subjects
  end
end
