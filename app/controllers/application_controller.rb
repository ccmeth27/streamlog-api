class ApplicationController < ActionController::API
    # protect_from_forgery with: :exception

    # helper_method :login!, :logged_in?, :current_user, :authorized_user?, :logout!, :encode_token, :decoded_token, :get_auth_header, :session_user
    
    # def login!
    #     session[:user_id] = @user.id
    # end
    
    def logged_in?
        !!session_user
    end
    
    # def current_user
    #     @current_user ||= User.find(session[:user_id]) if session[:user_id]
    # end
    
    # def authorized_user?
    #     @user == current_user
    # end
    
    def logout!
        session.clear
    end

    def encode_token(id)
        JWT.encode({user_id: id}, "super_secret_code")
    end
    
    def get_auth_header
      request.headers["Authorization"]
    end

    def decoded_token
      begin
        JWT.decode(get_auth_header, "super_secret_code")[0]["user_id"]
      rescue
        nil
      end
    end

    def session_user
      User.find_by(id: decoded_token)
    end
end
