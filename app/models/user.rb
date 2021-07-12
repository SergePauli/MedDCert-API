class User < ApplicationRecord
  has_secure_password
  #has_secure_password :recovery_password, validations: false

  belongs_to :organization
  belongs_to :person_name
  has_many :contacts, primary_key: "guid", foreign_key: "parent_guid"

  accepts_nested_attributes_for :contacts, reject_if: ->(attributes) { attributes["value"].blank? }, allow_destroy: true
  accepts_nested_attributes_for :person_name, reject_if: ->(attributes) { attributes["family"].blank? || attributes["given_1"].blank? }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
end
