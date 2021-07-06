class CreateVersions < ActiveRecord::Migration[6.1]
  def change
    create_table :versions, comment: "версии свидетельств" do |t|
      t.belongs_to :certificate, index: true, null: false
      t.integer :version_number, :limit => 2
      t.timestamps
    end
  end
end
