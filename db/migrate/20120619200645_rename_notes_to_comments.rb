class RenameNotesToComments < ActiveRecord::Migration
  def up
    rename_table :notes, :comments
  end

  def down
    rename_table :comments, :notes
  end
end
