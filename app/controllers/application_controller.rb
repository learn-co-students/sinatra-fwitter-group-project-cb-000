require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions #this is telling browser to allow info to be stored so log in works on multiple paths
     set :session_secret, "fwitter_secret"
   end

   get '/' do #this loads index page
     erb :index
   end

   helpers do
     def logged_in? #is the user logged in?
       !!current_user
     end

     def current_user
       @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
     end

   end
 end
