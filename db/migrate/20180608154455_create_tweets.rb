class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :content, limit: 280
      t.timestamps null: false
      # t.integer :user_id
    end
  end
end
