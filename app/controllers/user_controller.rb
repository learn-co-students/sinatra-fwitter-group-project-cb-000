class UserController < ApplicationController
  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods
  
  get '/users/:slug' do
    user = User.find_by_slug(params[:slug])
    if user
      @tweets = user.tweets
      erb :'tweets/show'
    end
  end

end
