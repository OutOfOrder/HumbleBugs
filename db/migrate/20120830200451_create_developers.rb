class CreateDevelopers < ActiveRecord::Migration
  def change
    create_table :developers do |t|
      t.string :name, null: false
      t.string :website
      t.string :time_zone
      t.text :address
      t.text :contact_information

      t.timestamps
    end
    add_index :developers, :name, unique: true
  end
end
