class CreateDoctor < ActiveRecord::Migration[6.1]
  def change
    create_table :doctors do |t|
      t.belongs_to :person, index: true
      t.belongs_to :organization, index: true
      t.belongs_to :position, index: true
      t.timestamps
    end
  end
end
