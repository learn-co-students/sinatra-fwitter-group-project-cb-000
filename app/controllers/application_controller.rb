require './config/environment'

class ApplicationController < Sinatra::Base
  register Sinatra::Reloader

   configure do
     enable :sessions
     set :session_secret, "my_application_secret"
  set :public_folder , Proc.new {File.join(root,"../public")}
    set :views, 'app/views'
  end



  get '/'do

    erb :index
  end

  get '/tweets'do
    erb :'/tweets/index'
  end

  get '/signup'do
      if logged_in?(session)
        puts "HELLO LOGGER"
        redirect to "/tweets"
      else
        puts "EEEEEEEEEEEEEEEEEEEEE"
    erb :'/users/create_user'
  end
  end

  get '/login'do

     erb :'/users/login'
  end
##########################################################################
  post '/login'do

     @user = User.find_by(username: params[:username])
     if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to "/tweets"
     else
       redirect to "/login"

     end
  end

  post '/signup'do

     if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?

        @user = User.create(username: params[:username], email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
       redirect to "/tweets"
     else
       redirect to "/signup"
     end


  end


  helpers do

    def logged_in?(session)
        !!session[:id]
    end

    def current_user
      User.find_by_id(session[:id])
    end
  end
end
