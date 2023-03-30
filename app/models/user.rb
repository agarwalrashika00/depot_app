class User < ApplicationRecord
  after_destroy :ensure_an_admin_remains
  validates :name, presence: true, uniqueness: true
  has_secure_password
  validates :email, uniqueness: true, allow_blank: true, format: {
    with: EMAIL_REGEXP
  }

  after_create_commit :send_welcome_mail

  before_destroy do
    throw :abort if email == 'admin@depot.com'
  end

  before_update do
    throw :abort if email == 'admin@depot.com'
  end

  private
  def ensure_an_admin_remains
    if User.count.zero?
      raise StandardError.new "Can't delete last user"
    end
  end

  def send_welcome_mail
    WelcomeUserMailer.with(user: self).welcome_user_email.deliver_now
  end
end
