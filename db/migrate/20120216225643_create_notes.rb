class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.text :note
      t.references :owner
      t.references :noteable, polymorphic: true

      t.timestamps
    end
    add_index :notes, :owner_id
    add_index :notes, [:noteable_id, :noteable_type]
  end
end
