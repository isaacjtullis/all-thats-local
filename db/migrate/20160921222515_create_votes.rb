class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.integer :topic_id, null: false

      t.timestamps
    end
  end
end
