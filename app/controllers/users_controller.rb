class UsersController < ApplicationController

  get '/signup' do
    erb :'users/create_user'
  end

  post '/signup' do
    if User.find_by(params[:user].except(:password)).authenticate(params[:user][:password])
      flash[:message] = "This user already exists. Please Log In."
      redirect to ('/')
    elsif User.find_by(params[:user][:email])
      flash[:message] = "This email address is already in use."
      redirect to ('/')
    end

    @user = User.create(params[:user])
    if @user
      redirect to ('/tweets')
    else
      flash[:message] = "There was an issue. Please try again."
      redirect to ('/')
    end
  end
end
