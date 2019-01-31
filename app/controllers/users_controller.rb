
class UsersController < ApplicationController

  get '/signup' do
    if session[:user_id] != nil
      redirect to '/tweets'
    else
      erb :'/users/new.html'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user == nil || (@user.try(:authenticate, params[:password]) == false)
      erb :'login_error.html'
    else
      session[:user_id] = @user.id
      redirect to '/tweets'
    end
  end

  post '/signup' do
    @user = User.create(params)
    @error = @user.errors.full_messages

    unless @error == []
      redirect to '/signup'
    else
      session[:user_id] = @user.id
      redirect to '/tweets'
    end
  end

  get '/tweets' do
    if !Helper.is_logged_in?(session)
      redirect to '/login'
    else
      @user = Helper.current_user(session)
      erb :'/users/account.html'
    end
  end

  get '/users/edit' do
    if !Helper.is_logged_in?(session)
      erb :'login_error.html'
    else
      @user = Helper.current_user(session)
      erb :'/users/edit.html'
    end
  end

  patch '/users' do
    @user = Helper.current_user(session).update(params[:user])
    redirect to '/tweets'
  end

  get '/logout' do
    if session[:user_id] == nil
      redirect to '/'
    else
      session.clear
      redirect to '/login'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])

    erb :"user/tweets.html"
  end
end
