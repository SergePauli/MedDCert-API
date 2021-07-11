class User < ApplicationRecord
  belongs_to :organization
  belongs_to :person_name
  has_many :contacts, primory_key: "guid", foreign_key: "parent_guid"
  accepts_nested_attributes_for :contacts, reject_if: ->(attributes) { attributes["value"].blank? }, allow_destroy: true
end
