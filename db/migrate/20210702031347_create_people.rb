class CreatePeople < ActiveRecord::Migration[6.1]
  def up
    create_table :people, primary_key: "id", id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.belongs_to :person_name, index: true, null: false, comment: "ФИО"
      t.string :SNILS, index: true, comment: "номер СНИЛС"
      t.timestamps
    end
  end

  def down
    drop_table :people
  end
end
