class Question < ApplicationRecord
  validates :body, presence: true, length: { maximum: 400 }

  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true
end
