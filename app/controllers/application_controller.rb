require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "secret"
  end

#----------HELPERS METHODS------------------------------------
  helpers do

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      @user = User.find_by(id: session[:user_id])
    end

  end
  #----------------------------------------------------------

  get '/' do
    erb :index
  end

  #----------UsersController---------------------------------

    get '/login' do
      if !logged_in?
        erb :login
      else
        redirect to '/tweets'
      end
    end

    post '/login' do
      @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect to '/tweets'
      else
        redirect to '/login'
      end
    end

    get '/signup' do
      if logged_in?
        redirect to '/tweets'
      else
        erb :signup
      end
    end

    post '/signup' do
      user = User.create(params)
    if user.save
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

    get '/logout' do
    session.clear
    erb :index
    end

  #----------TweetsController---------------------------------

  get '/tweets' do
  	if logged_in?
  		@user = current_user
  		erb :'tweets/index'
  	else
  		redirect '/login'
  	end
  end

end
