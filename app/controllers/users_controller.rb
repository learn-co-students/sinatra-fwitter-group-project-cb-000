class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect "/tweets"
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    if has_required_fields
      user = User.create(params[:user])
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

  get '/login' do
    if logged_in?
      @user = current_user
      redirect "/tweets"
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect "/login"
    else
      redirect "/"
    end
  end

  get '/users/:slug' do
    user = User.find_by_slug(params[:slug])
    @tweets = user.tweets

    erb :'/users/show'
  end

end
