class PersonName < ApplicationRecord
  validates :family, presence: true
  validates :given_1, presence: true
end
