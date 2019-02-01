class TweetsController < ApplicationController

  get '/tweets/new' do
    if !Helper.is_logged_in?(session)
      redirect to '/login'
    else
      @user = Helper.current_user(session)
      erb :'tweets/new.html'
    end
  end

  post '/tweets/new' do
    @tweet = Tweet.create(params)

    if @tweet.content.empty?
      redirect to '/tweets/new'
    else
      @user = Helper.current_user(session)
      @user.tweets << @tweet
      @user.save
      redirect to '/tweets'
    end
  end

  get '/tweets/:id' do
    @tweet = Tweet.find(params[:id])

    if !Helper.is_logged_in?(session)
      redirect to '/login'
    else
      erb :"tweets/show.html"
    end
  end

  get '/tweets/:id/edit' do

    if !Helper.is_logged_in?(session)
      redirect to '/login'
    end

    @tweet = Tweet.find(params[:id])
    if @tweet.user_id != Helper.current_user(session).id
      erb :'tweets/error.html'
    else
      erb :"tweets/edit.html"
    end

  end

  patch '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])

    if params[:content].empty?
      redirect to "/tweets/#{@tweet.id}/edit"
    else
      @tweet.update(content: params[:content])
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  delete '/tweets/:id/delete' do
    if !Helper.is_logged_in?(session)
      redirect to '/login'
    end

    @tweet = Tweet.find(params[:id])
    if @tweet.user_id != Helper.current_user(session).id
      redirect to '/tweets'
    else
    @tweet.destroy
    redirect to '/tweets'
    end
  end
end
