class Api::V1::SessionsController < ApplicationController
    def create
        user = User.find_by(username: params[:username])
      
        if user && user.authenticate(params[:password])
            token = encode_token(user.id)
            # session[:id] = user.id
            # login @user
            render json: {
                token: token,
                user: user
            }
        else
          render json: { 
            errors: ['no such user', 'verify credentials and try again or signup']
          }
        end
    end

    def encode_token(id)
      JWT.encode({user_id: id}, "super_secret_code")
    end

    def login 
      user = User.find_by(username: params[:username])
      if user && user.authenticate(params[:password])
        render json: user 
      else
        render json: {errors: 'Something went wrong'}
      end
    end

    def login!
      session[:user_id] = @user.id
    end

    def is_logged_in?
        if logged_in? && current_user
          render json: {
            logged_in: true,
            user: current_user
          }
        else
          render json: {
            logged_in: false,
            message: 'no such user'
          }
        end
    end

    def auto_login
      if session_user
        render json: session_user
      else 
        render json: {errors: "That ain't no user I ever heard of!"}
      end
    end

    def destroy
        logout!
        render json: {
          status: 200,
          logged_out: true
        }
    end

    private
    def session_params
        params.require(:user).permit(:username, :password)
    end
end
