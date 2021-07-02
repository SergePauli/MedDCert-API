class CreatePersonName < ActiveRecord::Migration[6.1]
  def change
    create_table :person_names, primary_key: "id", id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.string :family, :limit => 100
      t.string :firstname, :limit => 100
      t.string :middlename, :limit => 100
      t.uuid :parent, index: true, null: false, comment: "Идентификатор родительского элемента"
      t.timestamps
      t.index [:family, :firstname, :middlename]
    end
  end
end
