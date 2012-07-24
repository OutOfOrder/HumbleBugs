class AddUniqueIndexToTestResults < ActiveRecord::Migration
  def change
    add_index :test_results, [:release_id, :system_id], unique: true
  end
end
