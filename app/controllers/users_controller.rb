class UsersController < ApplicationController

  get "/signup" do
    if !logged_in? then
      erb :'users/create_user'
    else
      redirect '/tweets'
    end
  end

  post "/signup" do
    if !logged_in? then
      user = User.new(:username => params[:username], :password => params[:password])
      if params[:username] && params[:username] != "" && user.save
        session[:user_id] = user.id
      end
    end
    redirect '/tweets'
  end

  get "/login" do
    if !logged_in? then
      erb :'user/login'
    else
      redirect '/tweets'
    end
  end

  post "/login" do
    if !logged_in? then
      user = User.find_by(:username => params[:username])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
      end
    end
    redirect '/tweets'
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

end
