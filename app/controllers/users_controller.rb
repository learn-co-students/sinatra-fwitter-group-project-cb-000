
class UsersController < ApplicationController

  get '/signup' do
    erb :'/users/new.html'
  end

  get '/users/logon' do
    
  end

  post '/users' do
    @user = User.create(params[:user])
    @error = @user.errors.full_messages

    unless @error == []
      erb :'/users/error.html'
    else
      session[:user_id] = @user.id
      redirect to '/users/account'
    end

  end

  get '/users/account' do
    if !Helper.is_logged_in?(session)
      erb :'login_error.html'
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
    redirect to '/users/account'
  end

  get '/logout' do
    session.clear
    redirect to '/'
  end
end
