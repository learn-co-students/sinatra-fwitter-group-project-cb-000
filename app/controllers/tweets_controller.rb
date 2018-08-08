class TweetsController < ApplicationController

  get '/' do
    if logged_in?
      @tweets = Tweet.all
      erb :'/tweets/index'
    else
      redirect to "home/login"
    end
  end

  get '/new' do
    if logged_in?
      @tweets = Tweet.all
      erb :'/tweets/new'
    else
      redirect to "home/login"
    end
  end

  post '/' do
    if logged_in?
      if params[:content] == ""
        redirect to "/new"
      else
        @tweet = current_user.tweets.build(content: params[:content])
        if @tweet.save
          redirect to "/#{@tweet.id}"
        else
          redirect to "/new"
        end
      end
    else
      redirect to 'home/login'
    end
  end

  get '/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show'
    else
      redirect "/login"
    end
  end

  get '/:id/edit' do
    if logged_in?
        @tweet = Tweet.find_by_id(params[:id])
        if @tweet.user_id == current_user.id
          erb :'/tweets/edit'
        else
          redirect to "/#{@tweet.id}"
        end
    else
      redirect to "home/login"
    end
  end

  patch '/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == current_user.id
        @tweet.content = params[:content]
        if params["content"].empty?
          redirect to "/#{@tweet.id}/edit"
        end
        @tweet.save
        redirect to "/#{@tweet.id}"
      else
        redirect to "/#{@tweet.id}"
      end
    else
      redirect to "home/login"
    end
  end

  delete '/:id/delete' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == current_user.id
        @tweet.delete
      else
        redirect to "/#{@tweet.id}"
      end
    else
      redirect to "/home/login"
    end
  end

end
