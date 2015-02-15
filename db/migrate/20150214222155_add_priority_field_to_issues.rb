class AddPriorityFieldToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :priority, :integer, null: false, default: 50
    add_index :issues, [:priority], order: { :priority => :desc }
  end
end
