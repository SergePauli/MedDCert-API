class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.string :state, null: false, :limit => 2
      t.string :streetAddressLine, null: false
      t.string :aoGUID, :limit => 36
      t.string :houseGUID, :limit => 36
      t.string :codeKLADR, :limit => 25
      t.timestamps
    end
    add_index :addresses, :streetAddressLine
    add_index :addresses, :codeKLADR
  end
end
