class CreateAuthenticators < ActiveRecord::Migration[6.1]
  def up
    create_table :authenticators, comment: "кто и когда подписал свидетельство" do |t|
      t.string :type, index: true, comment: "тип подписи"
      t.datetime :time, comment: "время подписания документа"
      t.belongs_to :doctor, comment: "Doctor ID (информация о лице, подписавшем документ)"
      t.belongs_to :certificate, index: true, comment: "ID подписанного документа"
      t.timestamps
    end
  end

  def down
    drop_table :authenticators
  end
end
