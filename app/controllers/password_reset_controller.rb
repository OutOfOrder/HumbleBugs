class PasswordResetController < ApplicationController
  def new
  end

  def create
    if params[:email].blank?
      redirect_to forgot_password_url, :alert => "Specify an email address"
    else
      user = User.where("lower(email) = ?", params[:email].downcase).first
      user.send_password_reset if user
      redirect_to root_url, :notice => "Email sent with password reset instructions."
    end
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to forgot_password_url, :alert => "Password reset has expired."
    elsif @user.update_with_password(params[:user])
      redirect_to login_url, :notice => "Password has been reset."
    else
      render :edit
    end
  end
end
