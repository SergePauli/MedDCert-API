class AddLastLoginToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :login_times, :integer
  end
end
