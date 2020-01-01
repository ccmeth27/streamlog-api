class Api::V1::AuthController < ApplicationController

    def login
      user = User.find_by(username: params[:username])
  
      if user && user.authenticate(params[:password])
        token = encode_token(user.id)
        render json: {user: user, token: token}
      else
        render json: {errors: "You dun goofed!"}
      end
    end
  
    def auto_login
  
  
      if session_user
        render json: session_user
      else 
        render json: {errors: "That ain't no user I ever heard of!"}
      end
      
    end
  end