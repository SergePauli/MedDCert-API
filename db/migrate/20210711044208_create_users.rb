class CreateUsers < ActiveRecord::Migration[6.1]
  def up
    create_table :users, comment: "Пользователи системы" do |t|
      t.belongs_to :organization, null: false
      t.belongs_to :person_name, null: false
      t.string :email, null: false, index: true, unique: true
      t.string :password_digest
      t.uuid :activation_link, null: false, default: -> { "gen_random_uuid()" }
      t.string :roles, null: false, default: "USER"
      t.boolean :activated, null: false, default: false
      t.uuid :guid, null: false, default: -> { "gen_random_uuid()" }

      t.timestamps
    end
  end

  def down
    drop_table :users
  end
end
