class CreatePersonName < ActiveRecord::Migration[6.1]
  def change
    create_table :person_names, primary_key: "id", id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.string :family, index: true, comment: "фамилия"
      t.string :given_1, index: true, comment: "имя"
      t.string :given_2, index: true, comment: "отчество"
    end
  end
end
