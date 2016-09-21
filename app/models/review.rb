class Review < ActiveRecord::Base

  paginates_per 5
  max_paginates_per 10

  belongs_to :user
  has_many :comments

  CUSINE = ["French", "Thai", "American"]
  PRICES = ['10','15','20','30','100']

  validates :name, presence: true
  validates :cusine, inclusion: { in: CUSINE, message: "Not a valid cusine" }
  validates :review, presence: true
  validates :price, inclusion: { in: PRICES, message: "Not a valid price" }

  def self.search(search)
    where("name ILIKE ?", "%#{search}%")
  end
end
