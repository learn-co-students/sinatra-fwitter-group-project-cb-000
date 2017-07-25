require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "secret"
  end

#----------HELPERS METHODS------------------------------------
  helpers do

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      @user = User.find_by(id: session[:user_id])
    end

  end
  #----------------------------------------------------------

  get '/' do
    erb :index
  end

  get '/failure' do
  	erb :failure
  end

  get '/success' do
  	@user = current_user
  	erb :success
  end

  #----------UsersController---------------------------------

    get '/login' do
      if !logged_in?
        erb :login
      else
        redirect to '/tweets'
      end
    end

    post '/login' do
      @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect to '/tweets'
      else
        redirect to '/login'
      end
    end

    get '/signup' do
      if logged_in?
        redirect to '/tweets'
      else
        erb :signup
      end
    end

    post '/signup' do
      user = User.create(params)
    if user.save
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/users/:slug' do
  	@user = User.find_by_slug(params[:slug])
  	erb :'users/show'
  end

    get '/logout' do
      if logged_in?
        session.clear
        redirect '/login'
    	else
   		redirect '/'
    	end
    end
  #----------TweetsController---------------------------------

  get '/tweets' do
  	if logged_in?
      @tweets = Tweet.all
  		@user = current_user
  		erb :'tweets/index'
  	else
  		redirect '/login'
  	end
  end

  get '/tweets/new' do
  	if logged_in?
  		erb :'/tweets/new'
  	else
  		redirect '/login'
  	end
  end

  post '/tweets' do
  	if params[:content] != ""
	  	@tweet = current_user.tweets.build(content: params[:content])
	  	@tweet.save
	  	redirect "/tweets/#{@tweet.id}"
	  else
	  	redirect '/tweets/new'
	  end
  end

  get '/tweets/:id' do
  	if logged_in?
	  	@user = current_user
	  	@tweet = Tweet.find(params[:id])
	  	erb :'tweets/show'
	  else
	  	redirect '/login'
	  end
  end


 get '/tweets/:id/edit' do
 	if !logged_in?
    redirect '/login'
  else
  	@tweet = Tweet.find(params[:id])
	  	if @tweet.user == current_user
	  		erb :'tweets/edit'
	  	else
	  		redirect '/tweets'
	  	end
	  end
  end

  patch '/tweets/:id' do
  	if params[:content] != ""
	  	@tweet = Tweet.find(params[:id])
	  	@tweet.update(content: params[:content])
	  	redirect "/tweets/#{@tweet.id}"
	  else
	  	redirect "/tweets/#{params[:id]}/edit"
	  end
  end

  delete '/tweets/:id/delete' do
  	@tweet = Tweet.find(params[:id])
  	if @tweet.user == current_user
  		@tweet.delete
  		redirect '/tweets'
  	else
  		redirect '/tweets'
  	end
  end

end
