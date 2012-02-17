class AddReleaseTackingToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :reported_against_id, :integer

    add_column :issues, :fixed_in_id, :integer

    add_index :issues, :reported_against_id
    add_index :issues, :fixed_in_id
  end
end
