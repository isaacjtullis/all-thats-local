class AddPriceToReviews < ActiveRecord::Migration[5.0]
  def change
    add_column :reviews, :price, :string, null: false
  end
end
