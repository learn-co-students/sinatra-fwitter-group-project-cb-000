class TweetsController < ApplicationController

  get '/tweets' do
    if Helpers.is_logged_in?(session)
      @tweets = Tweet.all
      erb :'/tweets/index'
    else
      flash[:message] = "Please login to see tweets."
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if Helpers.is_logged_in?(session)
      erb :'/tweets/new'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    @tweet = Tweet.new(content: params[:content], user_id: session[:user_id])
    if @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    else
      flash[:message] = "Cannot create a blank tweet."
      redirect to '/tweets/new'
    end
  end

  get '/tweets/:id' do
    @tweet = Tweet.find_by(id: params[:id])
    if Helpers.is_logged_in?(session)
      erb :'/tweets/show'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by(id: params[:id])
    if Helpers.is_logged_in?(session) && @tweet.id == session[:user_id]
      erb :'/tweets/edit'
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by(id: params[:id])
    @tweet.content = params[:content]
    if @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    else
      flash[:message] = "Cannot create a blank tweet."
      redirect to "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    if Helpers.is_logged_in?(session) && @tweet.id == session[:user_id]
      @tweet = Tweet.find_by(id: params[:id])
      @tweet.delete
    end
    redirect to '/tweets'
  end

end
