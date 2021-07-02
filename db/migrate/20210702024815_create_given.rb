class CreateGiven < ActiveRecord::Migration[6.1]
  def change
    create_table :givens, id: false do |t|
      t.string :name, index: true, :unique => true
    end
  end
end
