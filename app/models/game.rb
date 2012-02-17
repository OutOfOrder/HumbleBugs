class Game < ActiveRecord::Base
  belongs_to :bundle, :inverse_of => :games
  has_many :ports, :inverse_of => :game
  has_many :issues, :inverse_of => :game
  has_many :releases, :inverse_of => :game

  STATES = [
      ['Prospective', :prospective],
      ['Planned', :planned],
      ['In Development', :development],
      ['QA Testing', :testing],
      ['Completed', :completed]
  ]

  validates_presence_of :name, :state, :description
  validates_inclusion_of :state, :in => STATES.map { |m| m.second.to_s }, :message => "state %{value} is not a valid state"
end
