class UsersController < ApplicationController
  get '/signup' do
    redirect '/tweets' if logged_in?
    slim :'users/signup'
  end

  post '/signup' do
    @user = User.new(params[:user])

    if @user.save
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    redirect '/tweets' if logged_in?
    slim :'users/login'
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id

      redirect '/tweets'
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
    user = User.find_by_slug(params[:slug])



    @tweets = user.tweets
    slim :'users/index'
  end
end
