class TweetsController < ApplicationController

  get '/tweets' do
    redirect to '/login' if !logged_in?
    @tweets = Tweet.all
    erb :'tweets/tweets'
  end

  get '/tweets/new' do
    redirect to '/login' if !logged_in?
    erb :'tweets/create_tweet'
  end

  get '/tweets/:id' do
    redirect to '/login' if !logged_in?
    @tweet = Tweet.find(params[:id])
    erb :'tweets/show_tweet'
  end

  get '/tweets/:id/edit' do
    redirect to '/login' if !logged_in?
    if params[:content] == ""
      flash[:m] = "You CANNOT post an empty tweet ..."
      redirect to "/tweets/new"
    end
    @tweet = Tweet.find(params[:id])
    erb :'tweets/edit_tweet'
  end

  post "/tweets" do
    if params[:content] == ""
      flash[:m] = "You CANNOT post an empty tweet ..."
      redirect to "/tweets/new"
    end
    @tweet = Tweet.create(params)
    @tweet.user = current_user
    @tweet.save
    redirect to "/tweets/#{@tweet.id}"
  end

  patch "/tweets/:id" do
    redirect to '/login' if !logged_in?
    if params[:content] == ""
      flash[:m] = "You CANNOT post an empty tweet ..."
      redirect to "/tweets/#{params[:id]}/edit"
    end
    @tweet = Tweet.find(params[:id])
    if @tweet.user != current_user
      flash[:m] = "You cannot delete a tweet that is not yours."
      redirect to "/tweets/#{@tweet.id}/edit"
    end
    @tweet.update(:content => params[:content])
    @tweet.save
    flash[:m] = "Tweet successfully updated."
    redirect to "/tweets/#{@tweet.id}"
  end

  delete "/tweets/:id/delete" do
    redirect to '/login' if !logged_in?
    @tweet = Tweet.find(params[:id])
    if @tweet.user != current_user
      flash[:m] = "You cannot delete a tweet that is not yours."
      redirect to "/tweets/#{@tweet.id}/edit"
    end
    Tweet.find(params[:id]).destroy
    flash[:m] = "Tweet successfully deleted."
    redirect to "/tweets"
  end

end
