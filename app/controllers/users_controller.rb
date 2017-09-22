class UsersController < ApplicationController

  get '/login' do
    if logged_in?
      redirect :'/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    login(params)
  end

  get '/logout' do
    if logged_in?
      logout
    end
    redirect :'/login'
  end

  get '/signup' do
    if logged_in?
      redirect :'/tweets'
    else
      erb :'/users/create_user'
    end
  end

  # user registration
  post '/signup' do
    # {
    #   "username"=>"joe blogs",
    #   "email"=>"joe@example.com",
    #   "password"=>"password"
    # }

    # if the user can be saved, log them in
    # requirement for username, email & password implemented through active record validations
    user = User.new(params)
    if user.save
      session[:user_id] = user.id
      redirect :"/tweets"
    else
      # TODO add flash message - signup failure
      redirect :'/signup'
    end
  end

  get '/users/:slug' do
    # if logged_in?
      @user = User.find_by_slug(params[:slug])
      erb :'/users/show'
    # else
    #   redirect :'/login'
    # end

  end

end
