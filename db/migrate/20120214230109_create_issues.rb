class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.references :game, null: true
      t.text :description
      t.string :status

      t.timestamps
    end

    add_index :issues, :game_id
  end
end
