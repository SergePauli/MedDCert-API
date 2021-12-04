class User < PersonRecord
  has_secure_password

  belongs_to :organization
  has_many :contacts, primary_key: "guid", foreign_key: "parent_guid"

  accepts_nested_attributes_for :contacts, reject_if: ->(attributes) { attributes["telcom_value"].blank? }, allow_destroy: true

  validates_associated :organization

  def organization_name
    organization.name || organization.name_full
  end

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  scope :only_activated, -> { where(activated: true) }
  # Ex:- scope :active, -> {where(:active => true)}

  def self.permitted_params
    [:email, :password, :password_confirmation, :roles] | PersonRecord.permitted_params
  end
end
