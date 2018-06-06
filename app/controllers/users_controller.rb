class UsersController < ApplicationController

  #views (/users/..): create_user, login.erb, show.erb

  get '/signup' do
    erb :'users/create_user'
  end

  get '/login' do
    erb :'users/login'
  end

  get '/home' do
    @user = User.find_by(password_digest: session[:digest])
    erb :'users/show'
  end

  post '/signup' do
    if User.find_by(params[:user].except(:password)).authenticate(params[:user][:password])
      flash[:message] = "This account already exists. Please navigate to the login page."
      redirect to "/signup"
    else User.find_by(email: params[:user][:email])
      flash[:message] = "This email address is already in use. Please use a different email or Log in."
      redirect to "/signup"
    end
    @user = User.create(params[:user])
    session[:digest] = @user.password_digest
    redirect to '/home'
  end

  post '/login' do
    @user = User.find_by(params[:user].except(:password)).authenticate(params[:user][:password])
    if @user
      session[:digest] = @user.password_digest
      redirect to '/home'
    else
      flash[:message] = "Your username or password was incorrect please try again."
      redirect to '/login'
    end
    session[:digest]
  end
end
