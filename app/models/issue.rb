class Issue < ActiveRecord::Base
  belongs_to :game, :inverse_of => :issues
  belongs_to :reported_against, :class_name => 'Release', :inverse_of => :reported_issues
  belongs_to :fixed_in, :class_name => 'Release', :inverse_of => :fixed_issues
  has_many :notes, :as => :noteable

  STATUSES = [
      ['New', :new],
      ['Waiting Feedback', :feedback],
      ['Active', :active],
      ['Suspended', :suspended],
      ['Resolved', :completed]
  ]

  validates_presence_of :status, :description, :game_id
  validates_inclusion_of :status, :in => STATUSES.map { |m| m.second.to_s }, :message => "status %{value} is not a valid status"
end
