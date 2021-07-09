class Organization < ApplicationRecord
  has_one :address, foreign_key: "parent_guid", dependent: :destroy
  accepts_nested_attributes_for :address
end
