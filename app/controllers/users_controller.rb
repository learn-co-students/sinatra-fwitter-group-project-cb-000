class UsersController < ApplicationController

  #views (/users/..): create_user, login.erb, show.erb

  get '/signup' do
    erb :'users/create_user'
  end

  get '/login' do
    erb :'users/login'
  end

  get '/home' do
    @user = nil #TODO
    erb :'users/show'
  end

  post '/signup' do
    @user = User.create(params[:user])
    session[:digest] = @user.password_digest
    redirect to '/home'
  end

  post '/login' do
    @user = User.find_by(params[:user]).authenticate(params[:user_password])
    if @user
      session[:digest] = @user.password_digest
      redirect to '/home'
    else
      redirect to '/'
    end
    session[:digest]
  end
end
