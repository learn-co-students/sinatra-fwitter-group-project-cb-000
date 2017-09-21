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

  delete '/logout' do
    # TODO - destroy session
  end

  get '/signup' do
    if session[:user_id]
      redirect :'/tweets'
    end
    erb :'/users/create_user'
  end

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
    if !session[:user_id]
      redirect :'/login'
    else
      # if so display all tweets
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    end

  end



  helpers do

    def logged_in?

    end

    def current_user

    end

  end


end
