class Contact < ApplicationRecord
  def self.permitted_params
    [:id, :parent_guid, :telcom_value, :telcom_use, :main, :_destroy]
  end
end
