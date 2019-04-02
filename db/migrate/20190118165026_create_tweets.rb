class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :content
<<<<<<< HEAD
      t.integer :user_id
=======
      t.string :user_id
>>>>>>> e498e2874dc1c65b9572a3cc6e96705b3cab98ce
    end
  end
end
