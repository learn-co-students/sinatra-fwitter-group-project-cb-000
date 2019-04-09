class UsersController < ApplicationController
  register Sinatra::ActiveRecordExtension
  set :views, Proc.new { File.join(root, "../views/") }

  get '/login' do

    if Helpers.is_logged_in?(session)
      redirect to '/tweets'
    end

    @error = ""
    erb :'users/login'
  end

  post '/login' do
    stuff = User.find_by(username: params[:username])
    if !!stuff == false
      @error = "Username not recognized"
      erb :'users/login'
    elsif stuff.authenticate(params[:password]) == false
      @error = "Valid username, incorrect password"
      erb :'users/login'
    else
      session[:user_id] = stuff.id
      redirect to '/tweets'
    end
  end

  get '/logout' do
    if Helpers.is_logged_in?(session)
      erb :'users/logout'
    else

      redirect to '/'

      erb :'index'

    end
  end

  post '/logout' do

    if Helpers.is_logged_in?(session)
      session.clear
      redirect to '/'
    else
      redirect to '/'
    end
  end

  get '/signup' do
    if Helpers.is_logged_in?(session)
      redirect to '/tweets'
    end

    session.clear
    erb :'index'
  end

  get '/signup' do

    @error = ""
    erb :'users/create_user'
  end

  post '/signup' do
    @error = signup_error(params)
    if User.find_by(username: params[:username]) != nil
      @error += "Username already in use"
    end
    if @error != ""

      #erb :'users/create_user'
      redirect to '/signup'
    else
      dude = User.create(username: params[:username], password: params[:password], email: params[:email], slug: slugify(params[:username]))

      erb :'users/create_user'
    else
      dude = User.create(username: params[:username], password: params[:password], email: params[:email])

      session[:user_id] = dude.id
      redirect to '/tweets'
    end
  end

  get '/users/:slug' do
    @user = User.find_by(slug: params[:slug])
    erb :'users/show'
  end


end
