class CreatePosition < ActiveRecord::Migration[6.1]
  def change
    create_table :positions do |t|
      t.integer :Priority, index: true
      t.string :Name
    end
  end
end
