class CreateContacts < ActiveRecord::Migration[6.1]
  def up
    create_table :contacts, primary_key: "id", id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.string :telcom_value, index: true, comment: "telcom value"
      t.string :telcom_use, comment: "telcom use-attribute"
      t.boolean :main, null: false, default: false, comment: "Признак основного контакта"
      t.uuid :parent_guid, index: true, null: false, comment: "Идентификатор родительского элемента"
      t.timestamps
    end
  end

  def down
    drop_table :contacts
  end
end
