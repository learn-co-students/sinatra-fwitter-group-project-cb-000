class UserController < Sinatra::Base
  get "/signup" do
    erb :'users/create_user'       #filename  spec'd in the lab, otherwise would have called it :signup
  end

  post "/signup" do
    user = User.new(:username => params[:username], :password => params[:password])

    if params[:username] != "" && params[:password] != "" && user.save
        session[:user_id] = user.id
        redirect "/login"
    else
        redirect "/failure"
    end
  end

  get '/account' do
    @user = User.find(session[:user_id])
    erb :account
  end


  get "/login" do
    erb :'/users/login'
  end

  post "/login" do
    user = User.find_by(:username => params[:username])
    if params[:username] != "" && params[:password] != "" && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/account"
    else
      redirect "/failure"
    end
  end

  get "/success" do
    if logged_in?
      erb :'users/show'
    else
      redirect "/login"
    end
  end

  get "/failure" do
    puts "There was a problem, please <a href='/'>try again</a>"
  end

  get "/logout" do
    session.clear
    redirect "/"
  end

end
