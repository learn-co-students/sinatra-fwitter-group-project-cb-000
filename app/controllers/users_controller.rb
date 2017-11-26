class UsersController < ApplicationController

    get "/signup" do
        if !logged_in?
            erb :"users/create_user"
        else
            redirect "/tweets"
        end
    end

    post "/signup" do
        if params.all? {|param, value| !value.empty?}
            user = User.create(params)
            session[:user_id] = user.id
            redirect "/tweets"
        else
            flash[:error] = "Please fill in all the boxes."
            redirect "/signup"
        end
    end

    get "/login" do
        if !logged_in?
            erb :"users/login"
        else
            redirect "/tweets"
        end
    end

    post "/login" do
        if params.all? {|param, value| !value.empty?}
            user = User.find_by(username: params[:username])
            if user && user.authenticate(params[:password])
                session[:user_id] = user.id
                redirect "/tweets"
            else
                flash[:error] = "Username or password not found."
                redirect "/login"
            end
        else
            flash[:error] = "Please fill in all the boxes."
            redirect "/login"
        end
    end

    get "/logout" do
        if logged_in?
            session.clear
            redirect "/login"
        else
            redirect "/"
        end
    end

    get "/users/:slug" do
        @user = User.find_by_slug(params[:slug])
        if @user
            erb :"users/show"
        else
            "Much ERROR. Much Frustration! ;)"
        end
    end
end