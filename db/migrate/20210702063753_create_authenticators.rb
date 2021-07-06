class CreateAuthenticators < ActiveRecord::Migration[6.1]
  def change
    create_table :authenticators, primary_key: "id", id: :uuid, default: -> { "gen_random_uuid()" }, comment: "кто и когда подписал свидетельство" do |t|
      t.datetime :time, comment: "время подписания документа"
      t.belongs_to :doctor, comment: "Doctor ID (информация о лице, подписавшем документ)"
      t.belongs_to :certificate, comment: "ID подписанного документа"
      t.timestamps
    end
  end
end
