class AddVotesToFavorites < ActiveRecord::Migration[5.0]
  def change
    add_column :favorites, :vote, :string
  end
end
