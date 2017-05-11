class TweetsController < ApplicationController
  before { redirect '/login' unless logged_in? }
  get '/tweets' do
    redirect '/login' unless logged_in?

    @tweets = Tweet.all
    slim :'tweets/index'
  end

  get '/tweets/new' do
    redirect '/login' unless logged_in?

    slim :'tweets/new'
  end

  post '/tweets' do
    tweet = current_user.tweets.build(content: params[:content])

    if tweet.save
      redirect '/tweets'
    else
      redirect :'tweets/new'
    end
  end

  get '/tweets/:id' do
    redirect '/login' unless logged_in?
    @tweet = Tweet.find_by(id: params[:id])
    slim :'tweets/show'
  end

  get '/tweets/:id/edit' do
    @tweet = current_user.tweets.find_by(id: params[:id])
    slim :'tweets/edit'
  end

  patch '/tweets/:id' do
    tweet = current_user.tweets.find_by(id: params[:id])
    tweet.content = params[:content]
    redirect "/tweets/#{tweet.id}/edit" unless tweet.save
  end

  delete '/tweets/:id/destroy' do
    tweet = current_user.tweets.find_by(id: params[:id])
    tweet.destroy if tweet

    redirect '/tweets'
  end
end
