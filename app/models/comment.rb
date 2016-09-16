class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :review

  validates :description, presence: true
  validates :user_id, presence: true
  validates :review_id, presence: true
end
