class User < ApplicationRecord
  after_destroy :ensure_an_admin_remains
  validates :name, presence: true, uniqueness: true
  has_secure_password
  validates :email, uniqueness: true, allow_blank: true, format: {
    with: EMAIL_REGEXP
  }

  private
  def ensure_an_admin_remains
    if User.count.zero?
      raise StandardError.new "Can't delete last user"
    end
  end
end
