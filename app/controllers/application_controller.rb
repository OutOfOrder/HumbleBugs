class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_time_zone, :set_auth_user

  private

  def current_user
    if Rails.env.test?
      @current_user ||= session[:user]
    else
      @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
    end
  end
  helper_method :current_user

  def set_auth_user
    Authorization.current_user = current_user
  end

  def set_time_zone
    Time.zone = current_user.time_zone if current_user
  end

end
