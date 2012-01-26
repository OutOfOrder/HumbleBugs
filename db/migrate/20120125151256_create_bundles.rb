class CreateBundles < ActiveRecord::Migration
  def change
    create_table :bundles do |t|
      t.string :name
      t.datetime :target_date
      t.text :description
      t.string :state

      t.timestamps
    end

    add_index :bundles, :state
  end
end
