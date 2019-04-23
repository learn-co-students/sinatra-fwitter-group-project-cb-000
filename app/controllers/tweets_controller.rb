class TweetsController < ApplicationController

  get '/tweets' do
    @tweets = Tweet.all
    erb :'tweets/tweets'
  end

  get '/tweets/new' do
    erb :'tweets/new'
  end

  post '/tweets' do
    #create new tweet here!
    redirect "/tweets/#{tweet.id}"
  end

  get '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    erb :'tweets/show_tweet'
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    erb :'tweets/edit_tweet'
  end

  patch '/tweets/:id' do
    #handle edit tweet here!
    redirect "/tweets/#{tweet.id}"
  end

  delete 'tweets/:id/delete' do
    tweet = Tweet.find(params[:id])
    tweet.delete
    redirect '/tweets'
  end

end
