class CreateAddressPrints < ActiveRecord::Migration[6.1]
  def change
    create_table :address_prints, id: false do |t|
      t.belongs_to :address, index: { unique: true }, foreign_key: true
      t.string :region
      t.string :district
      t.string :city
      t.string :town
      t.string :street
      t.string :building
      t.string :flat
      t.timestamps
    end
  end
end
