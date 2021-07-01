class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts, primary_key: "id", id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.string :value
      t.string :use
      t.uuid :parent, null: false, comment: "Идентификатор родительского элемента"
      t.timestamps
    end
  end
end
