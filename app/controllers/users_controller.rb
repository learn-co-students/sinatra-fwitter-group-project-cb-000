class UsersController < ApplicationController


  get '/login' do
    if logged_in?

      redirect "/tweets"
    else
      erb :'users/login'
    end

  end

  get '/signup' do

    if logged_in?

      redirect '/tweets'
    else
      erb :'users/create_user'
    end

  end

  post '/signup' do
    if params['username'] == "" || params['email'] == "" || params['password'] == ""
      redirect '/signup'
    end
    @user = User.create(:username => params['username'], :email => params['email'], :password => params['password'])
    session["user_id"] = @user.id
    redirect "/tweets"
    # redirect "#{@user.username.slug}/tweets"
  end

  post '/login' do

    @user = User.find_by(:username => params['username'])
    if @user && @user.authenticate(params['password'])

      session[:user_id] = @user.id
      # redirect "#{@user.slug}/tweets"

      redirect "/tweets"
    else
      redirect '/login'
    end
  end

  get '/logout' do

    if logged_in?

      session = {}
      redirect '/login'
    else
      redirect "/"
    end

  end

  post '/logout' do

    session.clear
    redirect '/login'

  end

  get '/users/:username' do
    @user = User.find_by_slug(params['username'])
    erb :'users/show'
  end




end
