class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.text :description
      t.references :bundle
      t.string :state

      t.timestamps
    end
    add_index :games, :bundle_id
  end
end
