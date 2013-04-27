class ConfirmAccountController < ApplicationController
  def confirm
    @user = User.find_by_confirm_account_token(params[:id])
    if @user
      @user.confirm_account_token = nil
      @user.roles.build role: 'user'
      if @user.save
        if current_user == @user
          redirect_to @user, notice: 'Account Confirmed!'
        else
          redirect_to login_path, notice: 'Account Confirmed! Please Log in.'
        end
        return
      end
    end
    redirect_to root_path, notice: 'Failed to confirm account'
  end
end