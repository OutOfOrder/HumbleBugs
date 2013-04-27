class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.where("lower(email) = ?", params[:email].downcase).first
    if user && user.authenticate(params[:password])
      if params[:remember_me]
        cookies.permanent[:auth_token] = {
            value: user.auth_token,
            httponly: true
        }
      else
        cookies[:auth_token] = {
            value: user.auth_token,
            httponly: true
        }
      end
      if user.time_zone.nil? && params[:time_zone].present?
        tz = ActiveSupport::TimeZone[params[:time_zone]]
        if !tz.nil?
          user.update_attribute :time_zone, tz.name
        end
      end
      if params[:r].present?
        redirect_to request.protocol + request.host_with_port + params[:r], :notice => "Logged in!"
      else
        redirect_to root_url, :notice => "Logged in!"
      end
    else
      flash.now[:alert] = "Invalid email or password"
      render "new"
    end
  end

if Rails.env.test? || Rails.env.development?
  def secret_login
    if Rails.env.production?
      render status: 500, text: ''
      return
    end
    user = User.find(params[:id])
    session[:user_id] = user.id
    cookies[:auth_token] = {
        value: user.auth_token,
        httponly: true
    }
    render :json => {:result => 'ok'}
  end
end

  def destroy
    cookies.delete :auth_token
    redirect_to root_url, :notice => "Logged out!"
  end
end
