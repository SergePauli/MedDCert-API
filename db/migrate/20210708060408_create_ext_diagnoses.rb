class CreateExtDiagnoses < ActiveRecord::Migration[6.1]
  def change
    create_table :ext_diagnoses, comment: "МКБ10 том3 внешние причины заболеваемости и смертности" do |t|
      t.string :s_name, index: true, comment: "наименование"
      t.integer :sort, comment: "сортировка"
      t.string :ICD10, index: true, comment: "код ICD10"
    end
  end
end
