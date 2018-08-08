class UsersController < ApplicationController

  get '/' do
    @users = User.all
    erb :'users/index'
  end


  get '/:id' do
    @user = User.find(session[:user_id])
    erb :'users/show'
  end

end
