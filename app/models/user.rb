class User < ApplicationRecord
  extend FriendlyId
  friendly_id :nickname, use: :slugged

  has_secure_password

  before_validation :downcase_nickname, :downcase_email

  validates :email, presence: true, uniqueness: true, format: { with:  URI::MailTo::EMAIL_REGEXP }
  validates :nickname, uniqueness: true, length: 3..40, format: { with: /\A[a-zA-Z0-9_]+\z/ }

  has_many :questions, dependent: :delete_all

  include Gravtastic
  gravtastic(secure: true, filetype: :png, size: 100, default: 'retro')
  
  private

  def downcase_nickname
    nickname&.downcase!
  end

  def downcase_email
    email&.downcase!
  end
end
