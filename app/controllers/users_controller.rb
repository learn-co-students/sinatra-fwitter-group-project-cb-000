class UsersController < ApplicationController

  get '/signup' do
    erb :'users/create_user'
  end

  post '/signup' do
    if User.find_by(params[:user].except(:password))
      flash[:message] = "That username and email are already in use."
      redirect to ('/signup')
    elsif User.find_by(username: params[:user][:username])
      flash[:message] = "That username is already in use."
      redirect to ('/signup')
    elsif User.find_by(email: params[:user][:email])
      flash[:message] = "That email is already in use."
      redirect to ('/signup')
    else
      user = User.create(params[:user])
      session[:digest] = user.password_digest
      redirect to ("/#{@user.slug}/tweets")
    end

  end

  get '/login' do
    erb :'users/login'
  end

  post '/login' do
    @user = User.find_by(username: params[:user][:username])
    if !@user
      flash[:message] = "Incorrect username or password."
      redirect to ('/login')
    elsif @user.authenticate(params[:user][:password])
      session[:digest] = @user.password_digest
      redirect to ("/#{@user.slug}/tweets")
    elsif @user
      flash[:message] = "Incorrect password."
      redirect to ('/login')
    end

  end

end
