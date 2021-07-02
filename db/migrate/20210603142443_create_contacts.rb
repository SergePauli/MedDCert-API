class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts, primary_key: "id", id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.jsonb :telcom, index: true, comment: "Элемент telcom в формате JSON с поддержкой индекса"
      t.uuid :parent, index: true, null: false, comment: "Идентификатор родительского элемента"
      t.timestamps
    end
  end
end
