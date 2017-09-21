class TweetsController < ApplicationController

  get '/tweets' do
    # check user is logged in
    if logged_in?
      erb :'/tweets/tweets'
    else
      redirect :'/login'
    end
  end


end
