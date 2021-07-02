class CreatePerson < ActiveRecord::Migration[6.1]
  def change
    create_table :people, primary_key: "id", id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.string :SNILS
      t.timestamps
    end
  end
end
