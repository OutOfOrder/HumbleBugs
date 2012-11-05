class AddDeveloperIndexToPort < ActiveRecord::Migration
  def change
    add_index :ports, :developer_id
  end
end
