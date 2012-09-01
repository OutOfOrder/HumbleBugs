class AddDeveloperToGame < ActiveRecord::Migration
  def change
    add_column :games, :developer_id, :integer
  end
end
