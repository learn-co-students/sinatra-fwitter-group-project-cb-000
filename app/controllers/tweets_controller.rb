require './config/environment'

class TweetsController < ApplicationController
  
   before '/tweets*' do 
    if !logged_in?
      redirect :'/login'
    end
   end

  get '/' do 
    haml :index
  end

  get '/tweets' do
    @tweets = Tweet.all
    haml :'/tweets/tweets'
  end

  get '/tweets/new' do
    haml :'tweets/create_tweet'
  end

  get '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    haml :'tweets/show_tweet'
  end

  post '/tweets' do
      if params[:content] != ""
        @tweet = Tweet.create(user_id: params[:user_id], content: params[:content])
        redirect "/tweets/#{@tweet.id}"
      else
        redirect "/tweets/new"
      end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    if @tweet.user_id = session[:user_id]
      haml :'/tweets/edit_tweet'
    else
      redirect "/tweets/#{@tweet.id}"
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params["id"])
    if params[:content] != ""
      if @tweet.user_id == session[:user_id]
        @tweet.update(content: params[:content])
        @tweet.save
        redirect "/tweets/#{@tweet.id}"
      end
    else
      redirect "/tweets/#{params['id']}/edit"
    end
  end

  delete '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if @tweet.user_id == session[:user_id]
      Tweet.find(params[:id]).destroy
      redirect "/tweets"
    end
  end
end
