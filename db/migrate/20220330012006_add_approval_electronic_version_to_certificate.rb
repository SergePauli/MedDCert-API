class AddApprovalElectronicVersionToCertificate < ActiveRecord::Migration[6.1]
  def change
    add_column :certificates, :approval_e_version, :boolean
  end
end
