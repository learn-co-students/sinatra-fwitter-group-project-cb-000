module Helpers
    module InstanceMethods
        def logged_in?
            !!session[:user_id]
        end

        def current_user
            User.find_by_id(session[:user_id])
        end

        def form_type
            if current_user == @tweet.user
                "submit"
            else
                "hidden"
            end
        end
    end
end