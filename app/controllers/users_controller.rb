require './config/environment'

class UsersController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
  end

  get '/signup' do
    # binding.pry
    if(session[:user_id] == nil)
      erb :'users/create_user'
    else
      redirect '/tweets'
    end
  end

  post '/signup' do

    if((params[:username] == "" || params[:email] == "") || params[:password] == "")
      redirect :signup
    else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    end
  end



  post '/login' do
    # binding.pry
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password]) != false
      session[:user_id] = @user.id
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end



end
