class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts, primary_key: "id", id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.string :telcom_value, index: true, comment: "telcom value"
      t.string :telcom_use, comment: "telcom use-attribute"
      t.uuid :parent_guid, index: true, null: false, comment: "Идентификатор родительского элемента"
      t.timestamps
    end
  end
end
