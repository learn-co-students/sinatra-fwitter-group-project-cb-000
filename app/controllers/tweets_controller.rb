class TweetsController < ApplicationController
  register Sinatra::ActiveRecordExtension
  set :views, Proc.new { File.join(root, "../views/") }

  get '/tweets' do

    if !Helpers.is_logged_in?(session)
      redirect to '/login'
    end

     @tweets = Tweet.all
     erb :'tweets/tweets'
  end

  get '/tweets/new' do

    if !Helpers.is_logged_in?(session)
      redirect to '/login'
    end

    @error = ""
    erb :'tweets/new'
  end

  get '/tweets/:id' do

    if !Helpers.is_logged_in?(session)
      redirect to '/login'
    end

    @tweet = Tweet.find_by(id: params[:id])
    erb :'tweets/show_tweet'
  end



  post '/tweets' do

    if !Helpers.is_logged_in?(session)
      redirect to '/login'
    end

    if params[:content] == ""
      @error = "Tweets can't be blank"
      erb :'tweets/new'
    else
      tweet = Tweet.create(content: params[:content], user_id: session[:user_id])
    redirect to '/tweets'
    end
  end

  get '/tweets/:id/edit' do

    if !Helpers.is_logged_in?(session)
      redirect to '/login'
    end

    @tweet = Tweet.find_by(id: params[:id])
    @error = ""
    erb :'tweets/edit_tweet'
  end

  post '/tweets/:id' do

    if !Helpers.is_logged_in?(session)
      redirect to '/login'
    end

    @tweet = Tweet.find_by(id: params[:id])
    if params[:content] == ""
      @error = "Can't edit a tweet to have no content"
      erb :'/tweets/edit_tweet'
    end
    @tweet.content = params[:content]
    @tweet.save
    erb :'tweets/show_tweet'
  end

  post '/tweets/:id/delete' do

    if !Helpers.is_logged_in?(session)
      redirect to '/login'
    end

    tweet = Tweet.find_by(id: params[:id])
    tweet.destroy
    redirect to '/tweets'
  end


end
