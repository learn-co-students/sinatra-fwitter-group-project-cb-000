class TweetsController < ApplicationController

  # tweets#index action
  get '/tweets' do
    # check user is logged in
    if logged_in?
      erb :'/tweets/tweets'
    else
      redirect :'/login'
    end
  end

  # tweets#new action
  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect :'/login'
    end
  end

  # tweets#create action
  post '/tweets' do
    if logged_in?
      if params[:content] && params[:content] != ''
        tweet = Tweet.new(content: params[:content])
        tweet.user = current_user
        tweet.save
        redirect :"/tweets/#{tweet.id}"
      else
        # TODO add flash error message
        redirect :'/tweets/new'
      end
    else
      redirect :'/login'
    end
  end

  # tweets#show action
  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect :'/login'
    end
  end

  # tweets#edit action
  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if current_user.id == @tweet.user.id
        erb :'/tweets/edit_tweet'
      else
        redirect :'/tweets'
      end
    else
      redirect :'/login'
    end
  end

  # tweets#update action
  patch '/tweets/:id/edit' do

  end

  # tweet#delete action
  delete '/tweets/:id/delete' do

  end

end
