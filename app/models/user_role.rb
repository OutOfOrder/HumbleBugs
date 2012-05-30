class UserRole < ActiveRecord::Base
  belongs_to :user, :inverse_of => :roles

  validates_presence_of :user, :role
  validates_uniqueness_of :role, :scope => [:user_id]
end
