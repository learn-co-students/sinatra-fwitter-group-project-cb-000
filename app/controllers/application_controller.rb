require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'

    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  get '/login' do
   if session["user_id"]
     redirect '/tweets'
   end

    erb :'users/login'
  end

  get '/tweets' do
    if !session["user_id"]
      redirect '/login'
    end


    @tweets = User.find(user_id: session["user_id"])
    erb :'/tweets/tweets'
  end

  get '/logout' do
    if session["user_id"]
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

  post '/login' do
    @user = User.find_by(username: params["username"])

    if @user && @user.password == params["password"]
      session["user_id"] = @user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/signup' do
    if session["user_id"]
      redirect '/tweets'
    end

    erb :'users/create_user'
  end

  post '/signup' do
    if params["username"].empty? || params["email"].empty? || params["password"].empty?
      redirect '/signup'
    end

    @user = User.create(params)
    session["user_id"] = @user.id

    redirect 'tweets'
  end
end
