class AddReasonAcmeToCertificate < ActiveRecord::Migration[6.1]
  def change
    add_column :certificates, :reason_ACME, :string, limit: 6
  end
end
