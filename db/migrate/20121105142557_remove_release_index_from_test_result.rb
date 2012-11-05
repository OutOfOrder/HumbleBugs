class RemoveReleaseIndexFromTestResult < ActiveRecord::Migration
  def up
    remove_index :test_results, :release_id
  end

  def down
    add_index :test_results, :release_id
  end
end
