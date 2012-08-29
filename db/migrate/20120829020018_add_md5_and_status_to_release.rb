class AddMd5AndStatusToRelease < ActiveRecord::Migration
  def change
    add_column :releases, :checksum, :string
    add_column :releases, :status, :string, null: false, default: 'active'
  end
end
