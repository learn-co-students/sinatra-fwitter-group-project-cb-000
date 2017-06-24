class UsersController < ApplicationController

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

  # =================================== #
  # Registration and Log In/Log out     #
  # =================================== #
  get '/signup' do
    if Helpers.is_logged_in?(session)
      redirect to '/tweets'
    else
      erb :'/users/signup'
    end
  end

  post '/signup' do
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])

    if @user.save
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      flash[:message] = "All fields are required."
      redirect to '/signup'
    end
  end

  get '/login' do
    if Helpers.is_logged_in?(session)
      redirect to '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      flash[:message] = "Your username or password is incorrect. Please try again."
      redirect to '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect to '/login'
  end
end
