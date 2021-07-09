class CreatePosition < ActiveRecord::Migration[6.1]
  def change
    create_table :positions, comment: "справочник должностей медработников" do |t|
      t.integer :priority, index: true
      t.string :name
    end
  end
end
