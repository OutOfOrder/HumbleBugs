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
      redirect_to root_url, :notice => "Logged in!"
    else
      flash[:alert] = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    cookies.delete :auth_token
    redirect_to root_url, :notice => "Logged out!"
  end
end
