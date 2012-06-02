class AddUniqueIndexOnPredefinedTags < ActiveRecord::Migration
  def up
    remove_index :predefined_tags, [:context, :name]
    add_index :predefined_tags, [:context, :name], :unique => true
  end

  def down
    remove_index :predefined_tags, [:context, :name]
    add_index :predefined_tags, [:context, :name]
  end
end
