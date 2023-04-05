class User < ApplicationRecord
  after_destroy :ensure_an_admin_remains
  validates :name, presence: true, uniqueness: true
  has_secure_password
  validates :email, uniqueness: true, allow_blank: true, format: {
    with: EMAIL_REGEXP
  }

  after_create_commit :send_welcome_mail

  before_destroy :donot_destroy_admin, if: :admin?

  before_update :donot_update_admin, if: :admin?

  private
  def ensure_an_admin_remains
    if User.count.zero?
      raise StandardError.new "Can't delete last user"
    end
  end

  def send_welcome_mail
    WelcomeUserMailer.with(user: self).welcome_user_email.deliver_now
  end

  def admin?
    email == ADMIN_EMAIL
  end

  def donot_destroy_admin(user)
    user.errors.add :base, :cannot_destroy_admin, message: 'cannot destroy admin'
    throw :abort
  end

  def donot_update_admin(user)
    user.errors.add :base, :cannot_update_admin, message: 'cannot update admin'
    throw :abort
  end
end
