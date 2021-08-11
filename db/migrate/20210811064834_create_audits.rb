class CreateAudits < ActiveRecord::Migration[6.1]
  def up
    create_table :audits do |t|
      t.uuid :guid, index: true
      t.integer :action, :limit => 1, index: true
      t.string :table, :limit => 70
      t.string :field, :limit => 70
      t.string :detail
      t.string :before
      t.string :after
      t.integer :severity, :limit => 1, index: true
      t.string :summary
      t.belongs_to :user, index: true
      t.timestamps
    end
  end

  def down
    drop_table :audits
  end
end
