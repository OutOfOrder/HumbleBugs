class User < ActiveRecord::Base
  has_secure_password

  belongs_to :developer, :inverse_of => :users
  has_many :roles, :class_name => 'UserRole', :inverse_of => :user, :dependent => :destroy, :autosave => true

  has_many :systems, :inverse_of => :user, :dependent => :nullify, :autosave => true
  has_many :test_results, :inverse_of => :user

  validates_presence_of :password, :password_confirmation, :on => :create
  validates_uniqueness_of :email, :case_sensitive => false
  validates :email, :presence => true, :email => true
  validates_presence_of :name

  attr_accessible :email, :name, :password, :password_confirmation, :time_zone
  attr_accessible :email, :name, :password, :password_confirmation, :time_zone, :developer_id, :as => :manager

  before_create { generate_token(:auth_token) }
  before_save :set_null_fields

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

  def send_confirm_account
    generate_token :confirm_account_token
    self.confirm_account_sent_at = Time.zone.now
    save!
    UserMailer.confirm_account(self).deliver
  end

  def role_symbols
    if roles.present? then
      @role_symbols ||= roles.map { |m| m.role.to_sym }
    else
      [:unverified]
    end
  end

  def update_with_password(params = {})
    params ||= {}
    if params[:password].blank?
      self.errors.add(:password, :blank)
      false
    elsif params[:password_confirmation].blank?
      self.errors.add(:password_confirmation, :blank)
      false
    else
      update_attributes(params)
    end
  end

  def dashboard_columns
    if role_symbols.include?(:bundle_admin)
      [[:news],[:testing_games]]
    elsif role_symbols.include?(:porter)
      [[:news],[:testing_games, :recently_commented_on, :new_issues],[:game_ports]]
    elsif role_symbols.include?(:tester)
      [[:news],[:testing_games, :recently_commented_on, :new_issues]]
    else
      [[:news]]
    end
  end

private
  def set_null_fields
    self.time_zone = nil if self.time_zone.blank?
  end
end
