class Organization < ApplicationRecord
  #  audit needed
  def self.trackable?
    true
  end

  has_one :address, primary_key: "guid", foreign_key: "parent_guid", autosave: true, dependent: :destroy
  accepts_nested_attributes_for :address
  has_many :contacts, primary_key: "guid", foreign_key: "parent_guid", autosave: true, dependent: :destroy
  accepts_nested_attributes_for :contacts

  def to_s
    "MO[#{id}] #{name || name_full}"
  end

  def self.permitted_params
    [:id, :guid, :name, :name_full, :license, :license_data, :okpo, contacts_attributes: Contact.permitted_params, address_attributes: Address.permitted_params]
  end
end
