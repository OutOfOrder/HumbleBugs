class AddAuthorIndexToIssue < ActiveRecord::Migration
  def change
    add_index :issues, :author_id
  end
end
