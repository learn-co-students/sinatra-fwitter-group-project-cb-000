require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  	enable :sessions
  	set :session_secret, "password_security"
  end

  get '/' do
  	erb :index
  end

  get '/signup' do
  	if logged_in?
  		redirect '/tweets'
  	else
  		erb :signup
  	end
  end

  post '/signup' do
  	if params[:username] != "" && params[:email] != ""
  		if params[:password] != ""
  			@user = User.create(params)
	  		redirect '/tweets'
	  	else
	  		redirect '/signup'
	  	end
	  else
	  	redirect '/signup'
	  end
  end

  get '/login' do
  	if logged_in?
  		redirect '/tweets'
  	else
  		erb :login
  	end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

  get '/logout' do
  	if logged_in?
  		session.clear
  		redirect '/login'
  	else
  		redirect '/'
  	end
  end

  get '/users/:slug' do
  	@user = User.find_by_slug(params[:slug])
  	erb :'users/show'
  end

  get '/tweets' do
  	if logged_in?
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
  		redirect '/'
  	else
  		redirect '/tweets'
  	end
  end

  get '/failure' do
  	erb :failure
  end

  get '/success' do
  	@user = current_user
  	erb :success
  end


  helpers do

  	def logged_in?
			!!session[:user_id]
		end

		def current_user
			User.find(session[:user_id])
		end

	end





end