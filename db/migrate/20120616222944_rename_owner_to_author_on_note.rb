class RenameOwnerToAuthorOnNote < ActiveRecord::Migration
  def up
    rename_column :notes, :owner_id, :author_id
  end

  def down
    rename_column :notes, :author_id, :owner_id
  end
end
