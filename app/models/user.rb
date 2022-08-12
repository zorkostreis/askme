class User < ApplicationRecord
  has_secure_password

  before_save :downcase_nickname

  validates :email, presence: true, uniqueness: true,
    format: { with:  URI::MailTo::EMAIL_REGEXP, message: 'wrong email format' }
  validates :nickname, length: 3..40, uniqueness: true,
    format: { with: /\A[a-zA-Z0-9_]+\z/, message: 'only allows letters, numbers and _' }

  def downcase_nickname
    nickname.downcase!
  end
end
