require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :'home/home'
  end

  get "/signup" do
    if logged_in?
      redirect to "tweets"
    else
      erb :'home/signup'
    end
  end

  post "/signup" do
   if params[:username] == "" || params[:email] == "" || params[:password] == ""
     redirect 'home/signup'
   else
     @user = User.create(username: params[:username], password: params[:password])
     if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to "tweets"
    end
   end
  end

  get "/login" do
    if logged_in?
      redirect to "tweets"
    else
      erb :'home/login'
    end
  end

  post "/login" do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
     session[:user_id] = @user.id
     redirect to "tweets"
    else
     redirect to "home/failure"
    end
  end

 get "/failure" do
   erb :'home/failure'
 end

 get "/logout" do
   session.clear
   redirect "home/login"
 end

 helpers do
   def logged_in?
     !!session[:user_id]
   end

   def current_user
     @user = User.find(session[:user_id])
   end
 end

end
