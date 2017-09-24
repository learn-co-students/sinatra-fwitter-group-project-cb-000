require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'

    enable :sessions
    use Rack::Flash
    set :session_secret, "my_application_secret"

  end

  get '/' do
    erb :index
  end


  helpers do

    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def login(params)
      # check the the user has been registered and that we can authenticate them
      user = User.find_by(username: params[:username])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect :"/tweets"
      else
        flash[:message] = "Account not found, check spelling and try again"
        redirect :'/login'
      end
    end

    def logout
      session.clear
    end

    def path_info
      request.path_info
    end

  end


end
