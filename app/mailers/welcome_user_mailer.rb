class WelcomeUserMailer < ApplicationMailer
  def welcome_user_email
    @user = params[:user]

    mail(to: @user.email, subject: "Welcome new user!")
  end
end
