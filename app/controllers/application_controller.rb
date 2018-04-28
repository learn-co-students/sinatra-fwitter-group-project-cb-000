require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "not telling"
  end

  # Homepage

  get '/' do
    erb :index
  end

  # Sign Up

  get '/signup' do
    if logged_in?
      redirect "/#{current_user.slug}/tweets"
    else
      erb :signup
    end
  end

  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect "/error"
    else
      @user = User.new(username: params[:username], email: params[:email], password: params[:password])
      if @user.save
        session[:user_id] = @user.id
        redirect "/#{current_user.slug}/tweets"
      else
        redirect "/error"
      end
    end
  end

  # Log In

  get '/login' do
    if logged_in?
      redirect #{current_user.slug}weets"
    else
      erb :login
    end
  end

  post '/login' do
    puts params
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/#{current_user.slug}/tweets"
    else
      redirect 'error'
    end
  end

  # Log Out

  get '/logout' do
    if logged_in?
      session.clear
    end

    redirect '/'
  end

  # Users

  get '/:slug' do
    @user = User.find_by_slug(params[:slug])

    redirect "/#{current_user.slug}/tweets"
  end

  get '/:slug/tweets' do
    @user = User.find_by_slug(params[:slug])
    erb :tweets
  end

  # Tweets

  get '/:slug/tweets/new' do
    if logged_in?
      erb :new
    else
      redirect '/login'
    end
  end

  get '/:slug/tweets/:id' do
    @user = User.find_by_slug(params[:slug])
    @tweet = Tweet.find(params[:id])
    erb :show
  end\

  get '/:slug/tweets/:id/edit' do
    if current_user
      erb :edit
    else
      redirect "/error"
    end
  end

  # Errors

  get '/error' do
    erb :errors
  end

  # Helpers

  helpers do
    def current_user
      User.find(session[:user_id])
    end

    def logged_in?
      !!session[:user_id]
    end
  end
end
