module SessionsHelper
    def log_in(user)
        session[:remember_token] = user.remember_token
    end
end
