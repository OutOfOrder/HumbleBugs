class AddFieldsToReleases < ActiveRecord::Migration
  def change
    add_column :releases, :download_count, :integer, null: false, default: 0
    add_column :releases, :version, :string, null: false
  end
end
