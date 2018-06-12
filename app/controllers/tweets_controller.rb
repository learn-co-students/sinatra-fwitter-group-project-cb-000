class TweetsController < ApplicationController

  configure do
    set :public_folder, 'public'
    set :views, 'app/views/tweets'
  end


  get '/tweets' do
    redirect to '/login' if !logged_in?
    @tweets = Tweet.all
    erb :tweets
  end

  get '/tweets/:id' do
    flash[:m] = "Tweet ##{@tweet.id}"
    @tweet = Tweet.find(params[:id])
    erb :tweets
  end

  get '/tweets/new' do
    erb :create_tweet
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    erb :edit_tweet
  end

  post "/tweets" do
    @tweet = Tweet.create(params)
    redirect to "/tweets/#{@tweet.id}"
  end

  patch "/tweets/:id" do
    @tweet = Tweet.find(params[:id])
    @tweet.update(:content => params[:content])
    @tweet.save
    flash[:m] = "Tweet successfully updated."
    redirect to "/tweets/#{@tweet.id}"
  end

  delete "/tweets/:id/delete" do
    Tweet.find(params[:id]).destroy
    flash[:m] = "Tweet successfully deleted."
    redirect to "/tweets"
  end

end
