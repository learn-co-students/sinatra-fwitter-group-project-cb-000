class UsersController < ApplicationController

  get '/users' do
    erb :'/users/show'
  end

  get '/login' do
    if !logged_in?
      erb :'/users/login'
    else
      redirect "/tweets"
    end
  end

  get '/signup' do
    if !logged_in?
      erb :'/users/create_user'
    else
      redirect "/tweets"
    end
  end

  get '/show' do
    erb :'/users/show'
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect "/login"
    else
      redirect "/"
    end
  end

  post '/signup' do
    if params[:username] != "" && params[:email] != "" && params[:password] != ""
      @user = User.create(:email => params[:email], :username => params[:username], :password => params[:password])
      if @user.save
        session[:user_id] = @user.id
        redirect "/tweets"
      else
         redirect "/signup"
       end
    else
      redirect "/signup"
    end
  end



  post '/login' do
    user = User.find_by(:username => params[:username])
    if user != nil && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

end
