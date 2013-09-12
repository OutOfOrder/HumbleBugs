class Comment < ActiveRecord::Base
  belongs_to :author, :class_name => 'User'
  belongs_to :commentable, :polymorphic => true, :inverse_of => :comments, :touch => true

  validates_presence_of :commentable, :author, :comment
end
