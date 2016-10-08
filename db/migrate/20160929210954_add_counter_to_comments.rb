class AddCounterToComments < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :favorites_count, :integer
  end
end
