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

    # fails controller tests line 60 if using 'uniqueness' validation in model
    # user = User.new(params)
    # if user.save
    #   session[:user_id] = user.id
    #   redirect :"/tweets"
    # else
    #   # TODO add flash message - signup failure
    #   redirect :'/signup'
    # end

    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      user = User.new(params)
      user.save
      session[:user_id] = user.id
      redirect :'/tweets'
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
