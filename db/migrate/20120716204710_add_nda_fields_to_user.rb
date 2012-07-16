class AddNdaFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :nda_signed_date, :datetime
    add_index :users, :nda_signed_date
  end
end
