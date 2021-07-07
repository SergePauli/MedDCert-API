class CreateMedicalServs < ActiveRecord::Migration[6.1]
  def change
    create_table :medical_servs do |t|
      t.string :s_code, index: true, comment: "код услуги"
      t.string :name, index: true, comment: "наименование"
      t.integer :rel, limit: 1, default: 1
      t.date :dateout
    end
  end
end
