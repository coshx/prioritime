class UsersController < ApplicationController
  before_filter :authenticate_user_from_token!, except: [:authenticate, :create]

  def create
    user = User.new(user_params)

    if user.save
      render json: user, serializer: CurrentUserSerializer, status: 201
    else
      render json: user.errors.full_messages, status: 401
    end
  end

  def authenticate
    user = User.find_for_database_authentication(email: user_params[:email])

    if user && user.valid_password?(user_params[:password])
      render json: user, serializer: CurrentUserSerializer, status: 201
    else
      render json: "Invalid username or password.", status: 401
    end
  end

  def show
    user = User.find_by(id: params[:id])

    if user
      render json: user, serializer: CurrentUserSerializer, status: 200
    else
      render json: "Could not find the user.", status: 404
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end