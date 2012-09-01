class AddDeveloperToUser < ActiveRecord::Migration
  def change
    add_column :users, :developer_id, :integer
  end
end
