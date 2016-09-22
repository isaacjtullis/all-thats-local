class CreateDownVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :down_votes do |t|
      t.integer :comment_id
      t.integer :user_id
    end
  end
end
