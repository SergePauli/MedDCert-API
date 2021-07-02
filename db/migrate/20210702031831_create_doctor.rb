class CreateDoctor < ActiveRecord::Migration[6.1]
  def change
    create_table :doctors, primary_key: "id", id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.belongs_to :person
      t.belongs_to :organization
      t.belongs_to :position
      t.timestamps
    end
  end
end
