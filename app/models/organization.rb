class Organization < ApplicationRecord
  has_one :address, primary_key: "guid", foreign_key: "parent_guid", autosave: true, dependent: :destroy
  accepts_nested_attributes_for :address
  has_many :contacts, primary_key: "guid", foreign_key: "parent_guid", autosave: true, dependent: :destroy
  accepts_nested_attributes_for :contacts

  def to_s
    "MO[#{id}] #{organization.name || organization.name_full}"
  end
end
