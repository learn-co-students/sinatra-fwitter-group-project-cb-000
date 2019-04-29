class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in? then
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in? then
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if logged_in? then
      if params[:tweet][:content] != "" then
        tweet = Tweet.new()
        tweet.content = params[:tweet][:content]
        tweet.user = current_user
        tweet.save
        redirect "/tweets/#{tweet.id}"
      else
        redirect '/tweets/new'
      end
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in? then
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in? then
      @tweet = Tweet.find(params[:id])
      if current_user == @tweet.user then
        erb :'tweets/edit_tweet'
      else
        redirect "/tweets/#{@tweet.id}"
      end
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    tweet = Tweet.find(params[:id])
    if current_user == tweet.user then
      if params[:tweet][:content] != "" then
        tweet.content = params[:tweet][:content]
        tweet.save
      else
        redirect "/tweets/#{tweet.id}/edit"
      end
    end
    redirect "/tweets/#{tweet.id}"
  end

  delete '/tweets/:id/delete' do
    tweet = Tweet.find(params[:id])
    if current_user == tweet.user then
      tweet.delete
    end
    redirect '/tweets'
  end

end
