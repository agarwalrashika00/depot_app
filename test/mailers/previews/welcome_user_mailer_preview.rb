# Preview all emails at http://localhost:3000/rails/mailers/welcome_user_mailer
class WelcomeUserMailerPreview < ActionMailer::Preview
  def welcome_user_email
    user = User.new(name: 'Rashii', email: 'agarwalrashika00@gmail.com')
    WelcomeUserMailer.with(user: user).welcome_user_email
  end
end
