class CreateNullFlavors < ActiveRecord::Migration[6.1]
  def change
    create_table :null_flavors, comment: "values for nullFlavor attribute" do |t|
      t.uuid :parent_guid, null: false, index: true, comment: "who used that null flavor"
      t.string :parent_attr, null: false, comment: "null attribute"
      t.integer :value, :limit => 1, null: false, comment: "enum value of nullFlavor 1.2.643.5.1.13.13.99.2.286"
      t.timestamps
    end
  end
end
