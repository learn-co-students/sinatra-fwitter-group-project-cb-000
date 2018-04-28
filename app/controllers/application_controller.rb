require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  use Rack::Flash

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
      erb :'users/signup'
    end
  end

  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect "/login_error"
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
      redirect "#{current_user.slug}weets"
    else
      erb :'users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/#{current_user.slug}/tweets"
    else
      redirect '/login_error'
    end
  end

  # Log Out

  get '/logout' do
    if logged_in?
      session.clear
    end

    redirect '/'
  end

  # Errors

  get '/error' do
    erb :'errors/error'
  end

  get '/signup_error' do
    erb :'errors/signup_error'
  end

  get '/login_error' do
    erb :'errors/login_error'
  end

  # Users

  get '/:slug' do
    @user = User.find_by_slug(params[:slug])

    redirect "/#{current_user.slug}/tweets"
  end

  get '/:slug/tweets' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/tweets'
  end

  # Tweets

  get '/:slug/tweets/new' do
    if logged_in?
      @user = User.find_by_slug(params[:slug])
      erb :'tweets/new'
    else
      redirect '/error'
    end
  end

  post '/:slug/tweets' do
    @user = User.find_by_slug(params[:slug])
    if !params[:content].empty?
      @user.tweets << Tweet.create(content: params[:content])
      @user.save
      redirect "/#{current_user.slug}/tweets"
    else
      flash[:message] = "Tweets must contain at least one character."

      redirect "/#{current_user.slug}/tweets/new"
    end
  end

  get '/:slug/tweets/:id' do
    @user = User.find_by_slug(params[:slug])
    @tweet = Tweet.find(params[:id])
    erb :'tweets/show'
  end

  get '/:slug/tweets/:id/edit' do
    @user = User.find_by_slug(params[:slug])
    @tweet = Tweet.find(params[:id])
    if @user.id == session[:user_id]
      erb :'tweets/edit'
    else
      redirect "/error"
    end
  end

  patch '/:slug/tweets/:id' do
    @user = User.find_by_slug(params[:slug])
    @tweet = Tweet.find(params[:id])
    @tweet.update(content: params[:content])
    redirect "/#{current_user.slug}/tweets/#{@tweet.id}"
  end

  delete '/:slug/tweets/:id/delete' do
    @user = User.find_by_slug(params[:slug])
    if @user.id == session[:user_id]
      @tweet = Tweet.find(params[:id])
      @tweet.destroy
      redirect "/#{current_user.slug}/tweets"
    else
      redirect "/error"
    end
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
