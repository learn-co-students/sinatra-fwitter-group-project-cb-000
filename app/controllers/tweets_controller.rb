class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else 
      redirect to '/login'
    end
  end 
  
  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect to '/login'
    end
  end
  
  post '/tweets' do
    if params[:content] == ""
      redirect to '/tweets/new'
    else
    Tweet.create(content: params[:content], user_id: session[:user_id])
  end
  end
  
  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect to '/login'
    end
  end
  
 
  
  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet && @tweet.user == current_user
        erb :'tweets/edit_tweet'
      else
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end
  end
  
  
  
   
  
  patch '/tweets/:id' do
    
    if logged_in?
      if params[:content] != ""
        @tweet = Tweet.find_by_id(params[:id])
        if @tweet && @tweet.user == current_user
          @tweet.update(content: params[:content])
          redirect to "/tweets/#{@tweet.id}"
        else
        redirect to '/tweets'
        end
      else
        redirect to "/tweets/#{params[:id]}/edit"
      end
    else
      redirect to '/login'
    end
  end
  
  delete '/tweets/:id/delete' do #delete action
  
  if logged_in?
    
    
  @tweet = Tweet.find_by_id(params[:id])
  
  if @tweet && @tweet.user == current_user
     @tweet.delete
   
    
  else
    
     redirect to '/tweets'
    
  end
  
 
    
    
    
  else
    
    redirect to '/login'
    
  end
  
end
  
  

end

