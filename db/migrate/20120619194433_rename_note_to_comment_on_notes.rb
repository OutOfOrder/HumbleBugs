class RenameNoteToCommentOnNotes < ActiveRecord::Migration
  def up
    change_table :notes do |t|
      t.rename :note, :comment
      t.rename :noteable_type, :commentable_type
      t.rename :noteable_id, :commentable_id
    end
  end

  def down
    change_table :notes do |t|
      t.rename :comment, :note
      t.rename :commentable_type, :noteable_type
      t.rename :commentable_id, :noteable_id
    end
  end
end
