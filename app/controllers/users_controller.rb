class UsersController < ApplicationController

  get '/login' do
    if Helpers.is_logged_in?(session)
      redirect '/tweets'
    else
      erb :'users/login'
    end
  end

  get '/signup' do

    if Helpers.is_logged_in?(session)
      redirect '/tweets'
    else
      erb :'users/create_user'
    end

  end

  get '/logout' do
    if Helpers.is_logged_in?(session)
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  post '/signup' do
    params.each do |key, value|
      redirect '/signup' if value.empty?
    end

    user = User.create(username: params[:username], email: params[:email], password: params[:password])

    session[:user_id] = user.id

    redirect '/tweets'

  end

  post '/login' do

    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/' do
    erb :index
  end

end
