class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'project'
  end

  get '/' do
     erb :'index.html'
  end

  get '/login' do
    if session[:user_id] != nil
      redirect to '/tweets'
    else
      erb :'/login.html'
    end
  end

end
