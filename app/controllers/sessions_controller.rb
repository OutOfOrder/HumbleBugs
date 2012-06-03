class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email params[:email]
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
      if user.time_zone.nil?
        tz = ActiveSupport::TimeZone[params[:time_zone]]
        if !tz.nil?
          user.update_attribute :time_zone, tz.name
        end
      end
      redirect_to root_url, :notice => "Logged in!"
    else
      flash[:alert] = "Invalid email or password"
      render "new"
    end
  end

if Rails.env.test? || Rails.env.development?
  def secret_login
    user = User.find(params[:id])
    session[:user] = user
    #session[:user_id] = user.id
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
