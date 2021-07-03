class CreateIdentityCardTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :identity_card_types do |t|
      t.integer :parent_id, :limit => 2
      t.string :name
      t.integer :sort, :limit => 2
      t.binary :actual
    end
  end
end
