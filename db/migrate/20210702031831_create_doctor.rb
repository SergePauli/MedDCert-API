class CreateDoctor < ActiveRecord::Migration[6.1]
  def change
    create_table :doctors do |t|
      t.belongs_to :person_name, index: true, null: false, comment: "ФИО"
      t.string :SNILS, index: true, unique: true, comment: "номер СНИЛС"
      t.belongs_to :organization, index: true, comment: "Медорганизаия"
      t.belongs_to :position, comment: "должность"
      t.belongs_to :address, comment: "домашний адрес"
      t.timestamps
    end
  end
end
