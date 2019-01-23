require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/tweets' do
    # binding.pry
    if(session[:user_id] != nil)
      @user = User.find(session[:user_id])
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect '/users/login'
    end
  end

  get '/' do
    erb :index
  end

  get '/login' do
    if session[:user_id] == nil
      erb :'users/login'
    else
      redirect '/tweets'
    end
  end

  get '/logout' do
    if(session[:user_id] != nil)
      session[:user_id] = nil
      redirect 'users/login'
    else
      redirect '/'
    end
  end

  get '/tweets/new' do
    if (session[:user_id] != nil)
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets/new' do
    if(params[:content] != "")
      @tweet = Tweet.create(content: params[:content], user_id: session[:user_id])
      erb :'tweets/show_tweet'
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if(session[:user_id] != nil)
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect '/users/login'
    end
  end

  get '/tweets/:id/edit' do
    # binding.pry
    if(session[:user_id] != nil)
      @tweet = Tweet.find(params[:id])
      erb :'tweets/edit_tweet'
    else
      redirect '/users/login'
    end
  end

  patch '/tweets/:id/edit' do
    # binding.pry
    if(params[:content] == "")
      erb :"tweets/#{params[:id]}/edit"
    elsif(session[:user_id] != nil)
      @tweet = Tweet.find(params[:id])
      @tweet.update(content: params[:content])
      @tweet.save
      redirect to '/tweets'
    else
      redirect '/users/login'
    end
  end

  get '/users/:username' do
    # binding.pry
    @user = User.find_by_slug(params[:username])
    erb :'users/show'
  end

  delete '/tweets/:id/delete' do
    # binding.pry
    @tweet = Tweet.find_by_id(params[:id])
    if(session[:user_id] == nil)
      erb :'login'
    elsif(@tweet.user_id == session[:user_id])
      @tweet.destroy
      redirect to '/tweets'
    else
      redirect to '/tweets'
    end
  end


end
