class User < ApplicationRecord
  def self.trackable?
    return true
  end

  has_secure_password

  belongs_to :organization
  belongs_to :person_name
  has_many :contacts, primary_key: "guid", foreign_key: "parent_guid"

  accepts_nested_attributes_for :contacts, reject_if: ->(attributes) { attributes["value"].blank? }, allow_destroy: true
  accepts_nested_attributes_for :person_name, reject_if: ->(attributes) { attributes["family"].blank? || attributes["given_1"].blank? }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates_associated :organization
  validates :email, presence: true
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  scope :only_activated, -> { where(activated: true) }
  # Ex:- scope :active, -> {where(:active => true)}
  def organization_name
    organization.name || organization.name_full
  end

  def name
    "#{person_name.family} #{person_name.given_1} #{person_name.given_2}"
  end

  after_initialize do |user|
    if user.person_name_id == nil && user.person_name
      exist_person_name = PersonName.where(family: user.person_name.family).where(given_1: user.person_name.given_1).where(given_2: user.person_name.given_2)
      user.person_name = exist_person_name.first if exist_person_name && exist_person_name.first
    end
  end

  def self.permitted_params
    [:email, :organization_id, :password, :password_confirmation, :roles, person_name_attributes: [:family, :given_1, :given_2], contacts_attributes: [:value, :use]]
  end
end
