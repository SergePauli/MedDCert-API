class CreateDiagnoses < ActiveRecord::Migration[6.1]
  def up
    create_table :diagnoses, comment: "справочник МКБ-10" do |t|
      t.string :s_name, index: true, comment: "наименование"
      t.integer :sort, comment: "сортировка"
      t.string :ICD10, index: true, comment: "код ICD10"
    end
  end

  def down
    drop_table :diagnoses
  end
end
