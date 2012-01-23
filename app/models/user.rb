class User < ActiveRecord::Base
  has_secure_password

  validates_presence_of :password, :on => :create
  validates_uniqueness_of :email, :case_sensitive => false

  attr_accessible :email, :name, :password, :password_confirmation

  before_create { generate_token(:auth_token) }

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
end
