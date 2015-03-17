class SessionsController < Devise::SessionsController
  respond_to :json
  skip_before_filter :authenticate_user!

  def create
    super do |user|
      render json: user, serializer: CurrentUserSerializer, status: 201 and return
    end
  end
end