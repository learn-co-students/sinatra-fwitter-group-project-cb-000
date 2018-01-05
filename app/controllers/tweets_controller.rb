class TweetsController < ApplicationController
  get '/tweets' do
    redirect_to_login_page_if_not_logged_in

    @user = current_user
    @tweets = Tweet.all
    erb :'/tweets/tweets'
  end

  get '/tweets/new' do
    redirect_to_login_page_if_not_logged_in

    erb :'/tweets/create_tweet'
  end

  post '/tweets/new' do
    redirect "/tweets/new" if params[:content].empty?

    @tweet = Tweet.new(content: params[:content])
    current_user.tweets << @tweet
    @tweet.save

    redirect "/tweets"

  end

  get '/tweets/:id/edit' do
    redirect_to_login_page_if_not_logged_in
    redirect "/tweets" if !current_user.tweets.include?(Tweet.find_by_id(params[:id]))

    @tweet = Tweet.find_by_id(params[:id])

    erb :'/tweets/edit_tweet'
  end

  patch '/tweets/:id/edit' do
    (redirect "/tweets/#{params[:id]}/edit") if params[:content].empty?
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.update(content: params[:content])
    @tweet.save

    redirect "/tweets/#{@tweet.id}"
  end

  delete '/tweets/:id/delete' do
    redirect_to_login_page_if_not_logged_in
    (redirect "/tweets") if !current_user.tweets.include?(Tweet.find_by_id(params[:id]))
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.delete
    redirect "/tweets"
  end

  get '/tweets/:id' do
    redirect_to_login_page_if_not_logged_in
    @tweet = Tweet.find_by_id(params[:id])
    erb :'/tweets/show_tweet'
  end


end
