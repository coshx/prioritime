class UsersController < ApplicationController
  before_filter :authenticate_user_from_token!, except: [:create]

  def create
    user = User.new(user_params)

    if user.save
      user.make_admin_of_organization(params[:user][:organization_name])
      render json: user, serializer: CurrentUserSerializer, status: 201
    else
      render json: user.errors.full_messages, status: 401
    end
  end

  def profile
    user = current_user

    if user
      render json: user, serializer: ProfileSerializer, status: 200
    else
      render json: "You need to login.", status: 404
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
