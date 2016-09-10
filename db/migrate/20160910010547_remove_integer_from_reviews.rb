class RemoveIntegerFromReviews < ActiveRecord::Migration[5.0]
  def change
    remove_column :reviews, :integer, :string
  end
end
