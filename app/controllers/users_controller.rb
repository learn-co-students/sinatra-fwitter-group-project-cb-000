class UsersController < ApplicationController
  get '/users/:slug' do
#    if logged_in?
      @user = current_user
      erb :'/users/show'
#     else
#       redirect '/login'
#     end
  end
end
