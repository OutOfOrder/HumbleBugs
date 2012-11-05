class AddDeveloperIndexToGame < ActiveRecord::Migration
  def change
    add_index :games, :developer_id
  end
end
