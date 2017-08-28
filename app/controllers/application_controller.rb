require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
  	erb :index
  end


#Users Controller

  get '/login' do
    if !logged_in?
      erb :'/users/login'
    else
      redirect "/tweets" 
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id

      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

  get '/signup' do
    if !logged_in?
     erb :'/users/signup'
    else
     redirect '/tweets'
   end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect '/signup'
    else 
      @user = User.new(username: params[:username], email: params[:email], password: params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect "/tweets"
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect "/login"
    else      
      redirect "/login"
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end


# Tweets Controller
  get '/tweets/new' do
    if !logged_in?
      redirect '/login'
    else
  	  erb :'/tweets/new'
    end
  end

  get '/tweets' do
    if !logged_in?
      redirect "/login" 
    else
  	  @tweets = Tweet.all
      @user = current_user
      erb :'/tweets/index'
    end
  end

  get '/tweets/:id' do
    if !logged_in?
      redirect "/login"
    else
  	  @tweet = Tweet.find_by_id(params[:id])
  	  erb	:'/tweets/show'
    end
  end

  get '/tweets/:id/edit' do
    if !logged_in? 
      redirect '/login'
    else 
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/edit' 
    end
  end

  post '/tweets' do
    if params[:content] == ""
      redirect '/tweets/new'
    else
      @tweet = Tweet.new(content: params[:content], user_id: session[:user_id])
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    end
  end

  patch '/tweets/:id' do
    if params[:content] == ""
      redirect "/tweets/#{params[:id]}/edit"
    else      
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.content = params[:content]
      @tweet.save

      redirect "/tweets/#{@tweet.id}"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    if @tweet.user == current_user
      @tweet.delete

      redirect "/tweets"
    else
      redirect "/tweets"
    end
  end

  
  #helpers
  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find_by(session[:id])
    end
  end

end