class CreatePorts < ActiveRecord::Migration
  def change
    create_table :ports do |t|
      t.references :game
      t.references :porter
      t.string :state

      t.timestamps
    end
    add_index :ports, :game_id
    add_index :ports, :porter_id
  end
end
