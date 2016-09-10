class Review < ActiveRecord::Base

  belongs_to :user

  CUSINE = [
    ["French", "French"],
    ["Thai", "Thai"],
    ["American", "American"],
  ]

  PRICE = [
    [10, "10 dollars"],
    [25, "25 dollars"],
    [50, "50 dollars"],
    [100, "100 dollars"]
  ]

  validates :name, presence: true
  validates :cusine,
    presence: true
    #inclusion: { in: CUSINE.map { |cusine| cusine[1] } }
  validates :review, presence: true
  validates :price,
    presence: true
    #inclusion: { in: PRICE.map { |price| price[0] } }
end
