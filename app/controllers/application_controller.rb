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

   else
    #  erb :login
     # erb :error
     redirect '/tweets'

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

  get '/tweets' do
    # erb :tweets

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

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    # def current_user
    #   User.find(session[:user_id])
    # end
  end

end
