class AddDashboardToUser < ActiveRecord::Migration
  def change
    add_column :users, :dashboard, :text
  end
end
