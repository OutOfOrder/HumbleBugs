class Port < ActiveRecord::Base
  belongs_to :game, :inverse_of => :ports
  belongs_to :porter, :class_name => 'User'

  acts_as_taggable_on :platforms

  STATES = [
      ['Planned', :planned],
      ['In Development', :development],
      ['Completed', :completed]
  ]

  validates_presence_of :game, :state, :porter
  validates_inclusion_of :state, :in => STATES.map { |m| m.second.to_s }, :message => "state %{value} is not a valid state"
end
