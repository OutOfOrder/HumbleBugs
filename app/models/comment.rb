class Comment < ActiveRecord::Base
  belongs_to :author, :class_name => 'User'
  belongs_to :commentable, :polymorphic => true, :inverse_of => :comments

  validates_presence_of :commentable, :author, :comment
end
