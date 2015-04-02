class Bundle < ActiveRecord::Base
  has_many :games, :inverse_of => :bundle, :dependent => :nullify, :order => 'games.name ASC'
  has_many :issues, :through => :games, :order => 'issues.updated_at DESC'

  validates_presence_of :name, :state, :description
  validates_inclusion_of :state, :in => Types::Bundle::ALL_STATES.map(&:to_s), :message => "%{value} is not a valid state"

  def to_param
    "#{id}-#{name.parameterize}"
  end
end
