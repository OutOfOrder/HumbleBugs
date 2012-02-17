class Release < ActiveRecord::Base
  belongs_to :game, :inverse_of => :releases
  belongs_to :owner, :class_name => 'User'
  has_many :reported_issues, :class_name => 'Issue', :inverse_of => :reported_against
  has_many :fixed_issues, :class_name => 'Issue', :inverse_of => :fixed_in
end
