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
    erb :'/users/create_user'
  end

  post '/signup' do
    # {
    #   "username"=>"joe blogs",
    #   "email"=>"joe@example.com",
    #   "password"=>"password"
    # }
    
    # TODO
    # create user

    # log them in

    # redirect to tweets index
    redirect :'/tweets'
  end

  get '/tweets' do
    # check user is logged in

    # if so display all tweets
    erb :'/tweets/tweets'
  end



  helpers do

    def logged_in?

    end

    def current_user

    end

  end


end
