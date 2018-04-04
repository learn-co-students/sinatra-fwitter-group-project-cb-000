require './config/environment'

require 'sinatra/base'
require 'rack-flash'
class ApplicationController < Sinatra::Base
  enable :sessions
  use Rack::Flash


  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, "secret"

  end

  get '/' do
    erb :index
  end

  get '/login' do
    # erb :login

    if logged_in?
    #  erb :new
     redirect '/tweets'

   else
     erb :login
     # erb :error
    #  redirect '/error'

   end
  end

  get '/logout' do
    # erb :login

    if logged_in?
    #  erb :new
    session.clear

   redirect '/login'

# this maybe could be deleted
   else
    #  erb :login
     # erb :error
     redirect '/'
   #
   end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])

    if user
        flash[:notice] = "Welcome, #{user.username}"
        session[:user_id] = user.id
        redirect '/tweets'
    else

      redirect "/login"
    end

  end

  get '/tweets/new' do
    if logged_in?

      erb :new

    else
      redirect '/login'

  end
  end

  post '/tweets' do
    @tweet = Tweet.create(content: params[:content], user_id: session[:user_id])
    # binding.pry

    if @tweet.save
      # flash[:notice] = "great stuff"
      redirect "/tweets"
    else

      # flash[:notice] = "cant put in a blank one"

      redirect "/tweets/new"
    end
  end

  get '/tweets' do
    # erb :tweets

    @tweets = Tweet.all


    if logged_in?
    #  erb :new
    # session.clear

   erb :tweets

   else
    #  erb :login
     # erb :error
     redirect '/login'
   end
  end

# seems fine to me
# never hits this route.
# dumb
  get '/tweets/:id/edit' do

    # binding.pry
    if logged_in?

    @tweet = Tweet.find(params[:id])
    erb :'edit_tweet'
  else
   #  erb :login
    # erb :error
    redirect '/login'
  end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    # binding.pry

    # current_user has to own the tweet.
    if @tweet.user_id == current_user.id

    # @tweet = Tweet.find(params[:id])

    @tweet.destroy
    redirect '/tweets'

  end
  end

  post '/tweets/:id' do
    if logged_in? and current_user
      @tweet = Tweet.find(params[:id])

      @tweet.update(content: params[:content])

      if @tweet.save
          # could i just do '/tweets/:id' here ?
          redirect "/tweets/#{@tweet.id}"
      else
          redirect "/tweets/#{@tweet.id}/edit"
      end

    end
  end

  get '/tweets/:id' do

    if logged_in?

    @tweet = Tweet.find(params[:id])
    erb :'show_tweet'
  else
   #  erb :login
    # erb :error
    redirect '/login'
  end


  end

  get '/signup' do

    # not quite sure what it means
    # erb :signup

    if logged_in?
    #  erb :new
     redirect '/tweets'

   else
     erb :signup
     # erb :error
    #  redirect '/error'

   end
  end

  post '/signup' do

    user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])

    if user.save
        session[:user_id] = user.id
        redirect "/tweets"
    else
        redirect "/signup"
    end
    # erb :signup
    # redirect '/tweets'
  end

  get '/users/:slug' do
  # @songs = Song.all
  # this is tested to work..
  # p Song.all

  # class method.. spelt right, given an arg. arg has contents..
  # but doesnt return anything..
  # find by something else?

  # could cause issues
  @user = User.find_by(username: params[:slug])
  # binding.pry

  erb :'/users/show'
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
