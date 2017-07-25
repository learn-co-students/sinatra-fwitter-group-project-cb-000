class TweetController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/index'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if !params[:content].empty?
      @user = User.find_by(params[:user_id])
      @tweet = Tweet.create(content: params[:content], user_id: current_user.id)
      puts @tweet.content
      @tweet.save
      erb :'tweets/show'
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by(params[:id])
      erb :'tweets/edit'
    else
      redirect '/login'
    end
  end

  post '/tweets/:id' do
    tweet = Tweet.find_by(params[:id])
    if logged_in?
      if current_user.tweets.include?(tweet) && !params[:content].empty?
        tweet.content = params[:content]
        tweet.save
        redirect "/tweets/#{tweet.id}"
      else
        redirect "/tweets/#{tweet.id}/edit"
      end
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by(params[:id])
      @user = User.find_by(params[:user_id])
      if @tweet
        erb :'tweets/show'
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end

  post '/tweets/:id/delete' do
    tweet = Tweet.find_by(params[:id])
    if logged_in?
      if current_user && current_user.tweets.include?(tweet)
        tweet.destroy
        redirect "/tweets"
      end
    else
      redirect '/login'
    end
  end
end
