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

  get '/signup' do
    if session["user_id"]
      redirect '/tweets/tweets'
    end

    erb :'users/create_user'
  end

  post '/signup' do
    if params["username"].empty? || params["email"].empty? || params["password"].empty?
      redirect '/signup'
    end

    @user = User.create(params)
    session["user_id"] = @user.id

    redirect 'tweets/tweets'
  end
end
