class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  # by default audit not needed
  def self.trackable?
    false
  end
end
