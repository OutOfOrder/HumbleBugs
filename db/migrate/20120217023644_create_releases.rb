class CreateReleases < ActiveRecord::Migration
  def change
    create_table :releases do |t|
      t.references :game
      t.text :notes
      t.references :owner
      t.string :url

      t.timestamps
    end
    add_index :releases, :game_id
    add_index :releases, :owner_id
  end
end
