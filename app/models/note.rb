class Note < ActiveRecord::Base
  belongs_to :author, :class_name => 'User'
  belongs_to :noteable, :polymorphic => true

  validates_presence_of :noteable, :author
end
