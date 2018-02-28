class CreateTweets < ActiveRecord::Migration
  def up
    create_table :tweets do |t| #create a table for tweets
      t.string :content #tweets have content
      t.integer :user_id #tweets should belong to a user
  end
end

def down
  drop_table :tweets
end
end
