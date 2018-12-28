require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    erb :'users/create_user'
  end

  post '/signup' do
    # binding.pry
    if((params[:username] == "" || params[:email] == "") || params[:password] = "")
      redirect :signup
    else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      redirect :'/tweets'
    end
  end

  get '/login' do
    if sessions[:user_id] == nil
      erb :'users/login'
    else
      redirect '/'
    end
  end

end
