require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    erb :'users/create_user'
  end

  post '/signup' do

    if((params[:username] == "" || params[:email] == "") || params[:password] == "")
      redirect :signup
    else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id
      redirect :'/'
    end
  end

  get '/login' do
    if session[:user_id] == nil
      redirect '/login'
    else
      redirect '/'
    end
  end

  post '/login' do
    # binding.pry
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] == @user.id
      redirect '/'
    else
      redirect '/login'
    end
  end

end
