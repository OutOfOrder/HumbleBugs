class Game < ActiveRecord::Base
  belongs_to :bundle, :inverse_of => :games
  has_many :ports, :inverse_of => :game, :dependent => :destroy, :order => 'ports.created_at ASC'
  has_many :issues, :inverse_of => :game, :dependent => :destroy, :order => 'issues.updated_at DESC'
  has_many :releases, :inverse_of => :game, :dependent => :destroy, :order => 'releases.created_at DESC'

  acts_as_taggable_on :platforms

  scope :testing, where(:state => :testing)

  STATES = [
      ['Prospective', :prospective],
      ['Planned', :planned],
      ['In Development', :development],
      ['QA Testing', :testing],
      ['Completed', :completed]
  ]

  validates_presence_of :name, :state, :description
  validates_inclusion_of :state, :in => STATES.map { |m| m.second.to_s }, :message => "%{value} is not a valid state"
end
