require './config/environment'

class TweetsController < ApplicationController

  configure do
    enable :sessions
    set :session_secret, "secret"
  end

  get '/tweets' do
    @tweets = Tweet.all
    if User.logged_in?(session)
      erb :'tweets/tweets'
    else
      redirect to "/login"
    end
  end

  get '/tweets/new' do
    if User.logged_in?(session)
      erb :'tweets/new'
    else
      redirect to "/login"
    end
  end

  get '/tweets/:id' do
    if User.logged_in?(session)
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect to "/login"
    end
  end

  get '/tweets/:id/edit' do
    if User.logged_in?(session)
      @tweet = Tweet.find(params[:id])
      erb :'tweets/edit_tweet'
    else
      redirect to "/login"
    end
  end

  post '/tweets' do
    if User.logged_in?(session)
      user = User.current_user(session)
      tweet = Tweet.new(content: params[:content])
      tweet.user = user
      tweet.save
      redirect to "/tweets/new"
    else
      redirect to "/login"
    end
  end

  patch '/tweets/:id/edit' do
    if User.logged_in?(session)
      user = User.current_user(session)
      tweet = Tweet.find_by(id: params[:id])
        if tweet && user.id == tweet.user.id
          tweet.content = params[:content]
            if !tweet.save
              redirect to "/tweets/#{tweet.id}/edit"
            end
        end
      end

      redirect to '/tweets'
    end

    delete '/tweets/:id/delete' do
      if User.logged_in?(session)
        user = User.current_user(session)
        tweet = Tweet.find_by(id: params[:id])
        if tweet && user.id == tweet.user.id
          tweet.destroy
        end
      end
      redirect to '/tweets'
    end

  end
