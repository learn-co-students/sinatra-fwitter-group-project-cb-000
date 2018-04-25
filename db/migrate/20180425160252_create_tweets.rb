class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :title

    end
  end
end
