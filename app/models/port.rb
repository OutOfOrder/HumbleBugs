class Port < ActiveRecord::Base
  belongs_to :game, :inverse_of => :ports
  belongs_to :porter, :class_name => 'User'

  validates_presence_of :game
end
