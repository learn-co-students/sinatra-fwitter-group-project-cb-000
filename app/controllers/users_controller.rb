class UsersController < ApplicationController

  get '/users' do
    erb :'/users/show'
  end

  get '/login' do
    erb :'/users/login'
  end

  get '/signup' do
    if !logged_in?
      erb :'/users/create_user'
    else
      redirect "/tweets"
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

end
