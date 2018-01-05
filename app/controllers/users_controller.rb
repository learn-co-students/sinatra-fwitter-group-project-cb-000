class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect "/tweets"
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])

    if !User.find_by(username: params[:username]) && @user.save
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

end
