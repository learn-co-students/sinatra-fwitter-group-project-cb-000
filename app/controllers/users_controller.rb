class UsersController < ApplicationController

  #get "/users/#{user.slug}"
  get '/users/:slug' do

    puts "*** User Slug:#{user.slug}"
    @user = User.find_by_slug( params[:slug] )
    @user.tweets.each do |tweet|
      puts "*** In Slug Tweet:#{tweet.content}"
    end
    erb :'users/show'
   end


  get '/login' do

    if logged_in?
      redirect '/tweets'
    else
      erb :'users/login'
    end

  end


  post '/login' do
    @user = User.find_by(:username => params[:username])

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
      redirect '/'
    end

  end

  post '/logout' do

  end

  get '/signup' do

    if logged_in?
      redirect "/tweets"
    else
      erb :'users/signup'
    end

  end

  post "/signup" do
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      redirect '/signup'
    else
      @user = User.create( email: params[:email], username: params[:username], password: params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    end


  end

  helpers do
    def logged_in?
      #!!current_user
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

end
