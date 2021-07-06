class CreatePersonName < ActiveRecord::Migration[6.1]
  def change
    create_table :person_names, primary_key: "id", id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.string :family, index: true
      t.string :given_1, index: true
      t.string :given_2, index: true
      t.boolean :actual, index: true
      t.uuid :parent_guid, index: true, null: false, comment: "Идентификатор родительского элемента"
      t.timestamps
    end
  end
end
