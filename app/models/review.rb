class Review < ActiveRecord::Base

  belongs_to :user

  CUSINE = ["French", "Thai", "American"]
  PRICES = ['10','15','20','30','100']

  validates :name, presence: true
  validates :cusine, inclusion: { in: CUSINE, message: "Not a valid cusine" }
  validates :review, presence: true
  validates :price, inclusion: { in: PRICES, message: "Not a valid price" }
end
