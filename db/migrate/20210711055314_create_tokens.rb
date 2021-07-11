class CreateTokens < ActiveRecord::Migration[6.1]
  def up
    create_table :tokens, comment: "токены пользователей" do |t|
      t.belongs_to :user, comment: "one user - one session model"
      t.string :refresh_token, comment: "токен обновления"
    end
  end

  def down
    drop_table :tokens
  end
end
