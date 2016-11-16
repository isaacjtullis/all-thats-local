class Comment < ActiveRecord::Base
  paginates_per 5
  max_paginates_per 10

  belongs_to :user
  belongs_to :review
  has_many :favorites, dependent: :destroy
  has_many :down_votes, dependent: :destroy


  validates :description, presence: true
  validates :user_id, presence: true
  validates :review_id, presence: true

  def self.score(score)
    sum = 0
    sum = score += sum
  end
end
