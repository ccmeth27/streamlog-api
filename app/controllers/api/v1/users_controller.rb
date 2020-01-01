class Api::V1::UsersController < ApplicationController
  # skip_before_action :verify_authenticity_token
  def index
    @users = User.all
    if @users
      render json: {
        users: @users
      }
    else
      render json: {
        status: 500,
        errors: ['no users found']
      }
    end
end

def show
    @user = User.find(params[:id])
   if @user
      render json: {
        user: @user
      }
    else
      render json: {
        status: 500,
        errors: ['user not found']
      }
    end
end
  
def create
    user = User.new(
      username: params[:username],
      password: params[:password],
    )
    if user.save
      token = encode_token(user.id)
      render json: {
        status: :created,
        token: token,
        user: user
      }
    else 
      render json: {
        status: 500,
        errors: user.errors.full_messages
      }
    end
end

# def encode_token(id)
#   JWT.encode({user_id: id}, "super_secret_code")
# end
private
  
def user_params
    params.require(:user).permit(:username, :password)
end
end
