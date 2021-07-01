class CreateOrganizationContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :organization_contacts do |t|
      t.belongs_to :organization
      t.belongs_to :contact
      t.timestamps
    end
  end
end
