class Note < ActiveRecord::Base
  belongs_to :owner, :class_name => 'User'
  belongs_to :noteable, :polymorphic => true

  validates_presence_of :noteable, :owner
end
