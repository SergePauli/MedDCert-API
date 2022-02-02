class AddSmoCodeToOrganization < ActiveRecord::Migration[6.1]
  def change
    add_column :organizations, :sm_code, :string, limit: 2, null: false, default: "00"
  end
end
