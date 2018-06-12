class UsersController < ApplicationController

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'tweets/show'
  end

  get '/signup' do
    redirect to '/tweets' if logged_in?
    erb :'tweets/create_user'
  end

  get '/login' do
    redirect to '/tweets' if logged_in?
    erb :'tweets/login'
  end


  post '/signup' do
    user = User.create(params)
    session[:digest] = user.password_digest
    redirect to "/tweets"
  end

  post '/login' do
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:digest] = user.password_digest
      redirect to '/tweets'
    else
      flash[:m] = "Incorrect username or password"
      redirect to '/login'
    end

  end

end
