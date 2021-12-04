class CreateAddresses < ActiveRecord::Migration[6.1]
  def up
    create_table :addresses, primary_key: "id", id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.string :state, null: false, limit: 2, comment: "Код региона в ФНС"
      t.string :streetAddressLine, null: false, comment: "Адресная строка"
      t.uuid :aoGUID, comment: "Идентификатор fias:AOGUID"
      t.uuid :houseGUID, comment: "Идентификатор fias:HOUSEGUID"
      t.string :postalCode, limit: 6, comment: "Почтовый код"
      t.string :code, limit: 25, comment: "код КЛАДР адресного объекта"
      t.uuid :parent_guid, index: true, null: false, comment: "Идентификатор родительского элемента"
      t.boolean :actual, index: true, comment: "Признак актуальности адреса"
      t.string :house_number, comment: "Номер дома"
      t.string :struct_number, comment: "Строение"
      t.string :building_number, comment: "Корпус"
      t.string :flat_number, comment: "Квартира, помещение, офис"
      t.timestamps
    end
    add_index :addresses, :streetAddressLine
    add_index :addresses, :code
  end

  def down
    remove_index :addresses, :streetAddressLine
    remove_index :addresses, :code
    drop_table :addresses
  end
end
