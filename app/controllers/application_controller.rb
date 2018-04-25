require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "not telling"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    erb :signup
  end

  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      raise StandardError, "All boxes must be filled out!"
    else
      @user = User.create(params)
    end
    session[:id] = @user.id

    redirect "/<%= current_user.slug %>/tweets"
  end

  get '/login' do
    if logged_in?
      redirect "/<%= current_user.slug %>/tweets"
    else
      erb :login
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username], password: params[:password])
    session[:id] = @user.id

    # redirect "/<%= current_user.slug %>/tweets"
    erb :tweets
  end

  get '/:slug' do
    redirect "/<%= current_user.slug %>/tweets"
  end

  get '/:slug/tweets' do
    if logged_in?
      @user = User.find_by_slug(params[:slug])
      erb :tweets
    else
      redirect '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

  helpers do
    def current_user(session_hash)
      User.find(session_hash[:user_id])
    end

    def logged_in?
      !!session[:user_id]
    end
  end
end
