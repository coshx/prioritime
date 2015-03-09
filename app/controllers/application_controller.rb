class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  # skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }

  private

  def authenticate_user_from_token!
    if user = RequestAuthenticator.authenticate(request.headers["X-User-Token"])
      sign_in(user, store: false)
    else
      render_unauthorized
    end
  end

  def render_unauthorized
    if current_user
      message = "You are not authorized to perform this action."
    else
      message = "You need to sign in."
    end

    render json: message, status: 401
  end
end
