class Issue < ActiveRecord::Base
  belongs_to :game

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
