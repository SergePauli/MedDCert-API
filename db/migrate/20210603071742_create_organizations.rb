class CreateOrganizations < ActiveRecord::Migration[6.1]
  def up
    create_table :organizations do |t|
      t.string :oid, index: true, null: false
      t.string :okpo, comment: "код ОКПО"
      t.string :license, comment: "серия и номер лицензии на осуществление медицинской деятельности"
      t.string :license_data, comment: "указание на Федеральную службу по надзору в сфере здравоохранения и дату регистрации лицензии"
      t.string :parent_oid
      t.string :osp_oid
      t.string :children_oid
      t.string :old_oid
      t.string :name_full, null: false
      t.string :name, null: false
      t.integer :parent_id
      t.date :create_date
      t.date :modify_date
      t.date :delete_date
      t.string :delete_reason
      t.integer :organization_type, limit: 1
      t.uuid :guid, index: true, null: false
    end
  end

  def down
    drop_table :organizations
  end
end
