class TweetsController < ApplicationController

  get '/tweets' do
    redirect_if_not_logged_in
    @username = session[:username]
    erb :'tweets/index'    
  end

end 