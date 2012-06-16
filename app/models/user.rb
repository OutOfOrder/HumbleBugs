class User < ActiveRecord::Base
  has_secure_password

  has_many :roles, :class_name => 'UserRole', :inverse_of => :user, :dependent => :delete_all

  validates_presence_of :password, :on => :create
  validates_uniqueness_of :email, :case_sensitive => false

  attr_accessible :email, :name, :password, :password_confirmation, :time_zone

  before_create { generate_token(:auth_token) }

  scope :with_role, -> role do
    joins(:roles).where(:user_roles => {role: role.to_s})
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def send_password_reset
    generate_token :password_reset_token
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def role_symbols
    if roles.present? then
      roles.map { |m| m.role.to_sym }
    else
      [:unverified]
    end
  end
end
