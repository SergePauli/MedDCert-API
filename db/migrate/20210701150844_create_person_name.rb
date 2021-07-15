class CreatePersonName < ActiveRecord::Migration[6.1]
  def up
    create_table :person_names do |t|
      t.string :family, index: true, comment: "фамилия"
      t.string :given_1, index: true, comment: "имя"
      t.string :given_2, index: true, comment: "отчество"
    end
  end

  def down
    drop_table :person_names
  end
end
