require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'

    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  get '/login' do
   if logged_in?
     redirect '/tweets'
   end

    erb :'users/login'
  end

  get '/tweets' do
    if !logged_in?
      redirect '/login'
    end

    @tweets = Tweet.all
    erb :'/tweets/tweets'
  end

  get '/tweets/new' do
    if !session["user_id"]
      redirect '/login'
    end

    @user = User.find(session["user_id"])
    erb :'tweets/create_tweet'
  end

  post '/tweets' do
    @user = User.find(session["user_id"])

    if params["content"].empty?
      redirect '/tweets/new'
    else
      @tweet = Tweet.create(params)
      @user.tweets << @tweet
      redirect "/tweets/#{@tweet.id}"
    end
  end

  get '/tweets/:id' do
    if !session["user_id"]
      redirect '/login'
    end

    @tweet = Tweet.find(params["id"])
    erb :'tweets/show_tweet'
  end

  get '/logout' do
    if session["user_id"]
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

  post '/login' do
    @user = User.find_by(username: params["username"])

    if @user && @user.authenticate(params["password"])
      session["user_id"] = @user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/signup' do
    if session["user_id"]
      redirect '/tweets'
    end

    erb :'users/create_user'
  end

  post '/signup' do
    if params["username"].empty? || params["email"].empty? || params["password"].empty?
      redirect '/signup'
    end

    @user = User.create(params)
    session["user_id"] = @user.id

    redirect 'tweets'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    @tweets = @user.tweets

    erb :'users/show'
  end

  get '/tweets/:id/edit' do
    if !session["user_id"]
      redirect '/login'
    end

    @user = current_user
    @tweet = Tweet.find(params[:id])

    if @user && @user.id == @tweet.user_id
      erb :'tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do

    if params["content"].empty?
      redirect "/tweets/#{params[:id]}/edit"
    end

    @tweet = Tweet.find(params[:id])
    @tweet.content = params["content"]
    @tweet.save

    redirect "/tweets/#{@tweet.id}"
  end

  delete '/tweets/:id/delete' do
    @user = current_user
    @tweet = Tweet.find(params[:id])

    if @user && @user.id == @tweet.user_id
      Tweet.delete(params[:id])
      redirect '/'
    else
      redirect '/tweets'
    end
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end


end
