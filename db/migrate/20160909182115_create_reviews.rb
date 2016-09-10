class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.string :name, null: false
      t.string :cusine, null: false
      t.string :integer, null: false
      t.string :review, null: false
      t.integer :user_id
    end
  end
end
