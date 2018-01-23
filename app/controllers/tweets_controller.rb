class TweetsController < ApplicationController
  get '/tweets' do
   if logged_in?
     @user = current_user
     @tweets = Tweet.all
      erb :'/tweets/index'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      @user = current_user
       erb :'/tweets/new'
     else
       redirect '/login'
     end
  end

  post '/tweets' do
    if params[:content].empty? && logged_in?
      @message = "Tweet must contain text."
      erb :'/tweets/new'
    elsif logged_in?
      user = current_user
      tweet = Tweet.new(content: params[:content])
      tweet.user = user
      if tweet.save
        redirect '/tweets'
      else
        @message = "Tweet would not save."
        erb :'/tweets/new'
      end
    else
      redirect '/login'  
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @user = current_user
#      @tweet = Tweet.find_by(id: params[:id], user_id: @user.id)
      @tweet = Tweet.find(params[:id])
       erb :'/tweets/show'
     else
       redirect '/login'
     end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @user = current_user
      @tweet = Tweet.find_by(id: params[:id], user_id: @user.id)
       erb :'/tweets/edit'
     else
       redirect '/login'
     end
  end

  patch '/tweets/:id' do
    if params[:content].empty? && logged_in?
      @message = "Tweet must have text."
      @user = current_user
      @tweet = Tweet.find_by(id: params[:id], user_id: @user.id)
       erb :"/tweets/edit"
    elsif logged_in?
      @user = current_user
      @tweet = Tweet.find_by(id: params[:id], user_id: @user.id)
      @tweet.content = params[:content]
      @tweet.save
       redirect "/tweets/#{@tweet.id}"
     else
       redirect '/login'
     end
  end

  delete '/tweets/:id/delete' do
    if logged_in?
      @user = current_user
      if @tweet = Tweet.find_by(id: params[:id], user_id: @user.id)
        @tweet.destroy
      end
        redirect "/tweets"
     else
       redirect '/login'
     end
  end

end
