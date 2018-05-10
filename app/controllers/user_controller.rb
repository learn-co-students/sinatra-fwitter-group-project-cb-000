require './config/environment'

class UserController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    end
    haml :'/users/create_user'
  end

  post '/signup' do
    if params[:username] == ""  \
      || params[:email] == ""  \
      || params[:password] == "" 
      redirect '/signup'
    end
    session[:user_id] = User.create(params).id
    redirect '/tweets'
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      haml :'/users/login'
    end
  end

  post '/login' do
    @user=User.find_by(:username => params[:username])
    if @user
      session[:user_id] = @user.id
      redirect '/tweets'
    else 
      redirect '/signup'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

  get '/users/:slug' do
    @tweets = Tweet.all
    haml :'/users/show'
  end
end
