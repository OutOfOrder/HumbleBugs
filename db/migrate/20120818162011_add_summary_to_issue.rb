class AddSummaryToIssue < ActiveRecord::Migration
  def change
    add_column :issues, :summary, :string

    Issue.all.each do |i|
      i.update_attribute(:summary, ActionController::Base.helpers.truncate(i.description, length: 50))
    end
  end
end
