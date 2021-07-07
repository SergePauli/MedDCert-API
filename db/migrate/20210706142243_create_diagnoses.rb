class CreateDiagnoses < ActiveRecord::Migration[6.1]
  def change
    create_table :diagnoses, comment: "справочник МКБ-10" do |t|
      t.string :s_name, comment: "наименование"
      t.integer :sort, comment: "сортировка"
      t.string :ICD10, comment: "код"
    end
  end
end
