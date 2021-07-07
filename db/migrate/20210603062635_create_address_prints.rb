class CreateAddressPrints < ActiveRecord::Migration[6.1]
  def change
    create_table :address_prints, id: false, comment: "деструкторизированый адрес для печати свидетельства" do |t|
      t.belongs_to :address, index: true, unique: false
      t.string :region
      t.string :district
      t.string :city
      t.string :town
      t.string :street
      t.string :building
      t.string :flat
    end
  end
end
