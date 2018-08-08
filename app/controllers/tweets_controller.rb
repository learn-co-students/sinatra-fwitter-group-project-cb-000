class TweetsController < ApplicationController

  get '/tweets' do
    @tweets = Tweet.all
    erb :'/tweets/index'
  end

  get '/tweets/new' do
    @tweets = Tweet.all
    erb :'/tweets/new'
  end

  post '/tweets' do
    @tweet = Tweet.create(params[:tweet])
    @tweet.save
    redirect "tweets/#{@tweet.id}"
  end

  get '/tweet/:id/edit' do
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/edit'
  end

  get '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    erb :'/tweet/show'
  end

  post '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    @tweet.update(params[:tweet])
    redirect "tweets/#{@tweet.id}"
  end

  delete '/tweets/:id/delete' do #delete action
    @tweet = Article.find(params[:id])
    @tweet.delete
    redirect to '/tweets'
  end

end
