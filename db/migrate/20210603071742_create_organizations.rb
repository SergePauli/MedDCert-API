class CreateOrganizations < ActiveRecord::Migration[6.1]
  def change
    create_table :organizations, primary_key: "id", id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.string :oid, index: true, null: false
      t.string :parentOspOid
      t.string :ospOid
      t.string :childrenOspOid
      t.string :oldOid, null: false, :limit => 30
      t.string :nameFull, null: false
      t.string :nameShort, :limit => 100
      t.string :inn, :limit => 10
      t.string :kpp, :limit => 9
      t.string :ogrn, :limit => 16
      t.string :parentId
      t.date :createDate
      t.date :modifyDate
      t.date :deleteDate
      t.string :deleteReason
    end
  end
end
