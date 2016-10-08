class DeleteFavoritesCounterToComments < ActiveRecord::Migration[5.0]
  def up
    remove_column(:comments, :favorites_count)
  end
end
