class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_time_zone, :set_auth_user

  helper ExtraURLHelpers
  include ExtraURLHelpers

protected
  def current_user
    if Rails.env.test?
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
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
        format.js { render 'layouts/denied', formats: [:js] }
      end
    else
      redirect_to login_url(r: request.fullpath), :alert => 'You must login first'
    end
  end

private
  def set_auth_user
    Authorization.current_user = current_user
  end

  def set_time_zone
    Time.zone = current_user ? current_user.time_zone : nil
  end

protected
  def nested_check_with_attrs
    model = instance_variable_get(:"@#{controller_name.to_s.singularize}")
    allowed = false
    begin
      allowed = permitted_to! action_name.to_sym, model, :attribute_check => true
    rescue Authorization::NotAuthorized => e
      auth_exception = e
    end

    unless allowed
      logger.info "Permission denied: #{auth_exception}"
      if respond_to?(:permission_denied, true)
        # permission_denied needs to render or redirect
        send(:permission_denied)
      else
        send(:render, :text => "You are not allowed to access this action.",
          :status => :forbidden)
      end
    end
  end

  def find_polymorphic(allowed = [])
    params.each do |name, value|
      if name.ends_with?("_id")
        klass = name[0..-4]
        if allowed.blank? || allowed.include?(klass.to_sym)
          return klass.classify.constantize.find(value)
        else
          return nil
        end
      end
    end
    nil
  end

  def handle_unverified_request
    raise ActionController::InvalidAuthenticityToken
  end
end
