class AddConfirmTokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :confirm_account_token, :string
    add_column :users, :confirm_account_sent_at, :datetime
    add_index :users, :confirm_account_token, :unique => true
  end
end
