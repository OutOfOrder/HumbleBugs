class RemovePorterFromPort < ActiveRecord::Migration
  def up
    remove_column :ports, :porter_id
  end

  def down
    add_column :ports, :porter_id, :integer
  end
end
