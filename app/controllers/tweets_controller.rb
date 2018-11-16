class TweetsController < ApplicationController

  get "/tweets" do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      @tweets = Tweet.all
      erb :'/twitter/tweets'
    else
      redirect '/login'
    end
  end

  get "/tweets/new" do
    if Helpers.is_logged_in?(session)
      erb :'/twitter/create_tweet'
    else
      redirect '/login'
    end
  end

  get "/tweets/:id" do
    if Helpers.is_logged_in?(session)
      @tweet = Tweet.find_by(id: params[:id])
      erb :'/twitter/show_tweet'
    else
      redirect '/login'
    end
  end

  get "/tweets/:id/edit" do
    if Helpers.is_logged_in?(session)
      @tweet = Tweet.find_by(id: params[:id])
      erb :'/twitter/edit_tweet'
    else
      redirect '/login'
    end
  end

  post "/tweets/new" do
    if params[:content].empty?
      redirect '/tweets/new'
    else
      @user = Helpers.current_user(session)
      new_tweet = Tweet.create(content: params[:content], user_id: @user.id)
      redirect '/tweets'
    end
  end

  post '/tweets/:id/edit' do
    if params[:content].empty?
      redirect "/tweets/#{params[:id]}/edit"
    else
      tweet = Tweet.find_by(id: params[:id])
      tweet.content = params[:content]
      tweet.save
      redirect "/tweets/#{tweet.id}"
    end
  end

  post '/tweets/:id/delete' do
    tweet = Tweet.find_by(params[:id])
    user = Helpers.current_user(session)
    if tweet.user_id == user.id
      tweet.delete
    else
      redirect '/tweets'
    end
  end

end
