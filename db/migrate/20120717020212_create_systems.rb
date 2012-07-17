class CreateSystems < ActiveRecord::Migration
  def change
    create_table :systems do |t|
      t.references :user, null: false
      t.string :name, null: false
      t.text :description
      t.string :operating_system
      t.string :processor
      t.string :graphics_card
      t.string :graphics_driver

      t.timestamps
    end
    add_index :systems, :user_id
  end
end
