class CreateDiagnoses < ActiveRecord::Migration[6.1]
  def change
    create_table :diagnoses, comment: "справочник МКБ-10" do |t|
      t.string :s_name
      t.integer :sort
      t.string :ICD10
    end
  end
end
