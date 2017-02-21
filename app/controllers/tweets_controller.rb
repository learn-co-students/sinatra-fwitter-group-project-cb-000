class TweetsController < ApplicationController


  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/new'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/edit'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    if params[:content].blank?
      redirect "/tweets/#{@tweet.id}/edit"
    else
      @tweet.update(content: params[:content])
      redirect "/tweets/#{@tweet.id}"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
      tweet = Tweet.create(content: params[:content], user_id: current_user.id)
      if tweet.save
        redirect "/users/#{tweet.user.slug}"
      else
        redirect '/tweets/new'
      end
  end

  get '/tweets' do
    if logged_in?
      erb :'/tweets/index'
    else
      redirect '/login'
    end
  end

  delete '/tweets/:id/delete' do
    tweet = Tweet.find(params[:id])
    tweet.delete if tweet.user == current_user
    redirect '/tweets'
  end

end