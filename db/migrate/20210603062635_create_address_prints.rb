class CreateAddressPrints < ActiveRecord::Migration[6.1]
  def change
    create_table :address_prints, primary_key: "id", id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.string :region, null: false
      t.string :district
      t.string :city
      t.string :town
      t.string :street
      t.string :building
      t.string :flat
      t.belongs_to :address, index: true, foreign_key: true
      t.timestamps
    end
  end
end
