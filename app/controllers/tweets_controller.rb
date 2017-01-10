class TweetsController < ApplicationController
  get '/tweets' do
    if logged_in?
      erb :'tweets/index'
    else
      redirect to "/login"
    end
  end

  get '/tweets/new' do
    if logged_in?
      @tweet = Tweet.new
      erb :'tweets/new'
    else
      redirect to "/login"
    end
  end

  get '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if logged_in?
      erb :'tweets/show'
    else
      redirect to "/login"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/edit'
    else
      redirect to "/login"
    end
  end

  post '/tweets' do
    tweet = Tweet.new(params[:tweet])
    if tweet.save
      current_user.tweets << tweet
      current_user.save
      redirect to "/tweets/#{tweet.id}"
    else
      redirect to "/tweets/new"
    end
  end

  post '/tweets/:id' do
    tweet = Tweet.find(params[:id])
    if logged_in?
      if current_user.tweets.include?(tweet) && tweet.update(params[:tweet])
        redirect to "/tweets/#{tweet.id}"
      else
        redirect to "/tweets/#{tweet.id}/edit"
      end
    else
      redirect to "/login"
    end
  end

  post '/tweets/:id/delete' do
    tweet = Tweet.find(params[:id])
    if current_user && current_user.tweets.include?(tweet)
      tweet.destroy
    end
    redirect to "/tweets"
  end
end
