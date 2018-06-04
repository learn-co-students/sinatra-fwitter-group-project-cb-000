class TweetsController < ApplicationController

  #views (/tweets/..): create_tweet, edit_tweet, show_tweet, tweets

  get '/tweets' do
    @tweets = Tweet.all
    erb :'tweets/tweets'
  end

  get '/tweets/new' do
    erb :'tweets/create_tweet'
  end

  get '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    erb :'tweets/show_tweet'
  end
end
