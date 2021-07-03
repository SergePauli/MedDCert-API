class CreateAuthenticators < ActiveRecord::Migration[6.1]
  def change
    create_table :authenticators, primary_key: "id", id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.datetime :time, comment: "время подписания документа"
      t.uuid :assignedEntity, comment: "Doctor ID (информация о лице, подписавшем документ)"
      t.uuid :parent, comment: "ID подписанного документа"
      t.timestamps
    end
  end
end
