class Hashtag < ApplicationRecord
  HASHTAG_REGEXP = /#[[:word:]-]+/

  before_validation :downcase_name

  validates :name, presence: true, uniqueness: true

  has_many :question_hashtags, dependent: :destroy
  has_many :questions, through: :question_hashtags

  def to_param
    name
  end

  def downcase_name
    name&.downcase!
  end
end
