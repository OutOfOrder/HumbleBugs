class CreateTestResults < ActiveRecord::Migration
  def change
    create_table :test_results do |t|
      t.references :user, null: false
      t.references :system, null: false
      t.references :release, null: false
      t.string :rating, null: false
      t.text :comments

      t.timestamps
    end
    add_index :test_results, :user_id
    add_index :test_results, :system_id
    add_index :test_results, :release_id
  end
end
