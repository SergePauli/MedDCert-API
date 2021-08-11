class Audit < ApplicationRecord
  enum action: [:added, :updated, :removed, :archived,
                :commented, :imported, :exported, :signed_in, :signed_out]
  enum severity: [:success, :info, :warning, :error]
  validates :table, length: { maximum: 70, message: "%{value} length need to be < 71" }, allow_nil: true
  validates :field, length: { maximum: 70, message: "%{value} length need to be < 71" }, allow_nil: true
end
