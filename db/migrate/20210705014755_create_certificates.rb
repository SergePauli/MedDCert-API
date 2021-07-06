class CreateCertificates < ActiveRecord::Migration[6.1]
  def change
    create_table :certificates, comment: "таблица свидетельств" do |t|
      t.belongs_to :patient, index: true, comment: "id данных умершего"
      t.belongs_to :author, object: "Authenticator", index: true, comment: "id данных авторства"
      t.belongs_to :legal_authenticator, object: "Authenticator", comment: "id данных заверителя"
      t.belongs_to :authenticator, object: "Authenticator", comment: "id данных проверяющего"
      t.belongs_to :custodian, object: "Organization", index: true, comment: "id медорганизации"
      t.date :effectiveTime, null: false, comment: "дата создания документа"
      t.uuid :guid, index: true, null: false, default: -> { "gen_random_uuid()" }, unique: true
      t.timestamps
    end
  end
end
