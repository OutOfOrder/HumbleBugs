class User < ActiveRecord::Base
  has_secure_password

  validates_presence_of :password, :on => :create
  validates_uniqueness_of :email, :case_sensitive => false

  attr_accessible :email, :name, :password, :password_confirmation
end
