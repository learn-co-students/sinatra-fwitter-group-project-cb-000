class TweetsController < ApplicationController


    get '/tweets' do
      if logged_in?
        @tweets = Tweet.all
      erb :'tweets/tweets'
      else
      redirect to "/login"
      end
    end

    get '/tweets/new' do
      if logged_in?
      erb :'tweets/new'
      else
      redirect to "/login"
      end
    end


    post '/tweets' do
      if logged_in?
        if params["content"] == ""
          redirect to '/tweets/new'
        else
        @tweet = current_user.tweets.create(content: params["content"])
        if @tweet.save
          redirect to "/tweets/#{@tweet.id}"
          else redirect to "/tweets"
          end
        end
      else
        redirect to "/login"
      end
    end

    get '/tweets/:id' do
      if logged_in?
        @tweet = Tweet.find_by(id: params[:id])
        erb :'tweets/show_tweet'
      else
        redirect to "/login"
      end
    end


    get '/tweets/:id/edit' do
      if logged_in?
        if @tweet = current_user.tweets.find_by(id: params[:id])
          erb :'tweets/edit_tweet'
        else
          redirect to '/tweets'
        end
      else
        redirect to "/login"
      end
    end

    patch '/tweets/:id' do
      if logged_in?
            @tweet = Tweet.find_by(id: params[:id])
        if params["content"] == ""
          redirect to ("/tweets/#{@tweet.id}/edit")
        else
          if @tweet = current_user.tweets.find_by(id: params[:id])
            @tweet.update(content: params[:content])
            redirect to "/tweets/#{@tweet.id}"
          else
            redirect to '/tweets'
            end
          end
        else
          redirect to '/login'
        end
      end

    delete '/tweets/:id/delete' do
      if logged_in?
        if @tweet = current_user.tweets.find_by(params[:id])
        @tweet.delete
        end
         redirect to '/tweets'
      else
      redirect to '/login'
      end
    end
  end
