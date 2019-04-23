class UsersController < ApplicationController

  get '/signup' do
    if !logged_in? then
      erb :'users/create_user'
    else
      redirect '/tweets'
    end
  end

  post '/signup' do
    if !logged_in? then
      if params[:username] && params[:username] != "" && params[:email] && params[:email] != "" && params[:password] && params[:password] != ""
        user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
        if user.save
          session[:user_id] = user.id
        end
      else
        redirect '/signup'
      end
    end
    redirect '/tweets'
  end

  get '/login' do
    if !logged_in? then
      erb :'users/login'
    else
      redirect '/tweets'
    end
  end

  post '/login' do
    if !logged_in? then
      user = User.find_by(:username => params[:username])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
      else
        redirect '/login'
      end
    end
    redirect '/tweets'
  end

  get '/logout' do
    if logged_in? then
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

end
