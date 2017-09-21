require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'

    enable :sessions
    set :session_secret, "my_application_secret"
  end

  get '/' do
    erb :index
  end

  get '/login' do
    erb :'/users/login'
  end

  post '/login' do
    # TODO
    # - authenticate user
    # - create session
  end

  get '/logout' do
    # TODO - destroy session
  end

  get '/signup' do
    if logged_in?
      redirect :'/tweets'
    end
    erb :'/users/create_user'
  end

  # user registration
  post '/signup' do
    # {
    #   "username"=>"joe blogs",
    #   "email"=>"joe@example.com",
    #   "password"=>"password"
    # }

    # if the user can be saved, log them in
    user = User.new(params)
    if user.save
      session[:user_id] = user.id
      redirect :'/tweets'
    else
      # TODO add flash message - signup failure
      redirect :'/signup'
    end
  end

  get '/tweets' do
    # check user is logged in
    if !logged_in?
      redirect :'/login'
    else
      # if so display all tweets
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    end

  end



  helpers do

    def logged_in?
      !!@current_user
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def login(params)
      # check the the user has been registered and that we can authenticate them
      user = User.find(params[:username])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
      else
        redirect :'/login'
      end
    end

    def logout
      session.clear
    end

  end


end
