class CreateIdentities < ActiveRecord::Migration[6.1]
  def change
    create_table :identities, primary_key: "id", id: :uuid, default: -> { "gen_random_uuid()" }, comment: "ДУЛы" do |t|
      t.belongs_to :identity_card_type, comment: "тип документа"
      t.string :series, :limit => 50, comment: "серия документа"
      t.string :number, :limit => 50, comment: "номер документа"
      t.string :issueOrgName, comment: "кем выдан документ"
      t.string :issueOrgCode, :limit => 50, comment: "код подразделения"
      t.date :issueDate, comment: "дата выдачи"
      t.uuid :parent_guid, comment: "ID родительского элемента"
      t.timestamps
    end
  end
end
