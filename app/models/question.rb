class Question < ApplicationRecord
  validates :body, presence: true, length: { maximum: 400 }

  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  has_many :question_hashtags, dependent: :destroy
  has_many :hashtags, through: :question_hashtags

  after_save_commit :save_hashtags

  private
  
  def save_hashtags
    hashtag_names = find_hashtags("#{body} #{answer}")

    self.hashtags = 
      hashtag_names.map do |hashtag_name|
        Hashtag.find_or_create_by(name: hashtag_name)   
      end
  end

  def find_hashtags(text)
    text.scan(Hashtag::HASHTAG_REGEXP)
        .map { |hashtag| hashtag.delete('#').downcase }
        .uniq
  end
end
