class CreateSubjects < ActiveRecord::Migration[6.1]
  def change
    create_table :subjects, primary_key: "id", id: :uuid, default: -> { "gen_random_uuid()" }, comment: "элементы subject (ФИО и ДР матери ребенка до года)" do |t|
      t.belongs_to :person_name, null: false, comment: "ссылка на ФИО-обязательна"
      t.date :birthTime, comment: "дата рождения, @nullFlavor: UNK"
      t.timestamps
    end
  end
end
