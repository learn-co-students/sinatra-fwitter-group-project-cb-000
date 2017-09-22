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


  # tweets#update action


  # tweet#delete action

end
