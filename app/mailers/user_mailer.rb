class UserMailer < ActionMailer::Base
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user

    mail to: user.email
  end

  def confirm_account(user)
    @user = user

    mail to: user.email
  end

  def new_account(user)
    @user = user

    mail to: ENV['FEEDBACK_EMAIL'] || 'feedback@example.com',
         subject: default_i18n_subject(email: @user.email)
  end
end
