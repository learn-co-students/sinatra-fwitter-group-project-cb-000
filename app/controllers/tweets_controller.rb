class TweetsController < ApplicationController

  # tweets#index action
  get '/tweets' do
    # check user is logged in
    if logged_in?
      erb :'/tweets/tweets'
    else
      flash[:message] = "You need to be logged in to view tweets"
      redirect :'/login'
    end
  end

  # tweets#new action
  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      flash[:message] = "You need to be logged in to create a tweet"
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
        flash[:message] = "A tweet requires content to be saved!"
        redirect :'/tweets/new'
      end
    else
      redirect :'/login'
    end
  end

  # tweets#show action
  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      if @tweet
        erb :'/tweets/show_tweet'
      else
        flash[:message] = "Tweet could not be found"
        # redirect :"/users/#{current_user.slug}"
        redirect :"/tweets"
      end
    else
      flash[:message] = "You need to be logged in to view a tweet"
      redirect :'/login'
    end
  end

  # tweets#edit action
  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      if @tweet
        if current_user.id == @tweet.user.id
          erb :'/tweets/edit_tweet'
        else
          flash[:message] = "You must be the tweet author to edit a tweet"
          redirect :'/tweets'
        end
      else
        flash[:message] = "Tweet could not be found"
        # redirect :"/users/#{current_user.slug}"
        redirect :"/tweets"
      end
    else
      flash[:message] = "You need to be logged in to edit a tweet"
      redirect :'/login'
    end
  end

  # tweets#update action
  patch '/tweets/:id/edit' do
    if logged_in?
      tweet = Tweet.find_by(id: params[:id])
      if tweet && current_user.id == tweet.user.id
        content = params[:content]
        if content && content != ""
          tweet.content = content
          tweet.save
          redirect :"/tweets/#{tweet.id}"
        else
          flash[:message] = "A tweet requires content to be saved!"
          redirect :"/tweets/#{tweet.id}/edit"
        end
      else
        flash[:message] = "Error occurred when trying to edit tweet"
        redirect :"/users/#{current_user.slug}"
      end
    else
      redirect :'/login'
    end
  end

  # tweet#delete action
  delete '/tweets/:id/delete' do
    if logged_in?
      tweet = Tweet.find_by(id: params[:id])
      if tweet && current_user.id == tweet.user.id
        tweet.delete
        redirect :"/users/#{current_user.slug}"
      else
        flash[:message] = "You must be the tweet author to delete a tweet"
        redirect :"/tweets"
      end
    else
      redirect :'/login'
    end
  end

end
