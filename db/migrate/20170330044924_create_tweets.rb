class CreateTweets < ActiveRecord::Migration[5.0]
  def change
  	create_table :tweets do |t|
  		t.string :content
  	end
  end
end
