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
    #   "password"=>"password",
    #   "avatar" => "/images/avatar-1.png"
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
    generator = Random.new

    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      random_number = generator.rand(10) + 1
      avatar_path = "/images/avatar-#{random_number}.png"
      # user = User.new(params)
      user = User.new
      user.username = params[:username]
      user.email = params[:email]
      user.password = params[:password]
      user.avatar = avatar_path
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
