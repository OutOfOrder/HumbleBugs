class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_time_zone, :set_auth_user

  helper ExtraURLHelpers
  include ExtraURLHelpers

protected
  def current_user
    if Rails.env.test?
      @current_user ||= session[:user]
    else
      @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
    end
  end
  helper_method :current_user

  ## declarative authorization error handler redirector
  def permission_denied
    if current_user
      respond_to do |format|
        format.html { render 'layouts/denied' }
        format.js { render 'layouts/denied.js' }
      end
    else
      redirect_to login_url r: request.fullpath
    end
  end

private
  def set_auth_user
    Authorization.current_user = current_user
  end

  def set_time_zone
    Time.zone = current_user.time_zone if current_user
  end

protected
  def nested_index_check_with_attrs
    model = instance_variable_get(:"@#{controller_name.to_s.singularize}")
    allowed = false
    begin
      allowed = permitted_to! :index, model, :attribute_check => true
    rescue Authorization::NotAuthorized => e
      auth_exception = e
    end

    unless allowed
      logger.info "Permission denied: #{auth_exception}"
      if respond_to?(:permission_denied)
        # permission_denied needs to render or redirect
        send(:permission_denied)
      else
        send(:render, :text => "You are not allowed to access this action.",
          :status => :forbidden)
      end
    end
  end
end
