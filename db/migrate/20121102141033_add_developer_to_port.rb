class AddDeveloperToPort < ActiveRecord::Migration
  def change
    add_column :ports, :developer_id, :integer
  end
end
