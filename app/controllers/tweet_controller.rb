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
      tweet = Tweet.create(:content => params[:content], :user_id => current_user.id)
      redirect "/tweets/#{tweet.id}"
    else
      redirect '/tweets/new'
    end
  end

  post '/tweets/:id/delete' do
    if logged_in?
      tweet = Tweet.find_by_id(params[:id])
      if tweet.user_id == current_user.id
        tweet.destroy
        redirect '/tweets'
      else
        redirect "/tweets/#{tweet.id}"
      end
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/edit'
    else
      redirect '/login'
    end
  end

  post '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    if @tweet.user_id == current_user.id && !params[:content].empty?
      @tweet.content = params[:content]
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet
        erb :'tweets/singletweet'
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end

end