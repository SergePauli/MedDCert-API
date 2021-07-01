class CreateOrganizations < ActiveRecord::Migration[6.1]
  def change
    create_table :organizations, :id => false do |t|
      t.primary_key :id, :limit => 4
      t.string :oid, null: false, :limit => 36
      t.string :oldOid, null: false, :limit => 30
      t.string :scode, :limit => 6
      t.string :nameFull, null: false
      t.string :nameShort, :limit => 100
      t.string :inn, :limit => 10
      t.string :kpp, :limit => 9
      t.string :ogrn, :limit => 16
      t.string :po_code, :limit => 45
      t.date :createDate
      t.date :modifyDate
      t.date :deleteDate
      t.string :deleteReason
      t.belongs_to :address
    end
  end
end
