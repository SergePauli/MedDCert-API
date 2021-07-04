class CreateRelatedSubjects < ActiveRecord::Migration[6.1]
  def change
    create_table :related_subjects, primary_key: "id", id: :uuid, default: -> { "gen_random_uuid()" }, comment: "элементы relatedSubject (данные матери ребенка до года)" do |t|
      t.belongs_to :encoded_field, null: false, comment: "элемент code, не пустой"
      t.uuid :addr, null: false, comment: "ссылка на адрес или один из nullFlavor:  ASKU, NA, или UNK"
      t.uuid :subject, comment: "ссылка на данные матери, @nullFlavor: UNK"
      t.timestamps
    end
  end
end
