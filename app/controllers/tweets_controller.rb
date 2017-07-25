class TweetsController < ApplicationController

  get '/tweets' do
    redirect_if_not_logged_in
    @username = session[:username]
    @tweets = Tweet.all
    erb :'tweets/index'    
  end

  get '/tweets/new' do
    redirect_if_not_logged_in
    erb :'tweets/new'
  end

  get '/tweets/:id/edit' do
    redirect_if_not_logged_in
    @tweet = Tweet.find(params[:id])
    
    if session[:user_id] == @tweet.user_id
      erb :'tweets/edit'      
    else
      redirect to '/tweets'
    end
  end

  get '/tweets/:id' do
     redirect_if_not_logged_in
     @tweet = Tweet.find(params[:id])   
    erb :'tweets/show'
  end

  patch '/tweets/:id' do
    if params[:content].empty?
      redirect to "/tweets/#{params[:id]}/edit"
    else 
      tweet = Tweet.find(params[:id])
      tweet.update!(content: params[:content])
      redirect to "/tweets/#{tweet.id}"
    end
  end

  post '/tweets' do
    if params[:content].empty? 
      redirect to "/tweets/new"
    else
      user = User.find(session[:user_id])
      tweet = Tweet.create(content: params[:content], user: user)
      redirect to "/tweets/#{tweet.id}"
    end
  end

  delete '/tweets/:id/delete' do
    redirect_if_not_logged_in
    tweet = Tweet.find(params[:id])
    
    tweet.delete if session[:user_id] == tweet.user_id
    redirect to '/tweets'
  end

end 