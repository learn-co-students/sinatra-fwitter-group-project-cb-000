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


  helpers do

    def logged_in?

    end

    def current_user

    end

  end


end
