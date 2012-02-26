class CreatePredefinedTags < ActiveRecord::Migration
  def change
    create_table :predefined_tags do |t|
      t.string :name
      t.string :context, :limit => 128

      t.timestamps
    end
    add_index :predefined_tags, [:context, :name]
  end
end
