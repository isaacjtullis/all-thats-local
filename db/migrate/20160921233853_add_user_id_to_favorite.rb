class AddUserIdToFavorite < ActiveRecord::Migration[5.0]
  def change
    add_column :favorites, :user_id, :integer
  end
end
