class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }
  before_filter :authenticate_user_from_token!
  before_filter :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?


  private

    def authenticate_user_from_token!
      # if user = RequestAuthenticator.authenticate(request.headers["X-User-Token"])
      #   sign_in(user, store: false)
      # else
      #   render_unauthorized
      # end
      authenticate_with_http_token do |token, options|
        user_email = options[:user_email].presence
        user = user_email && User.find_by(email: user_email)

        if user && Devise.secure_compare(user.authentication_token, token)
          sign_in user, store: false
        end
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

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) << :organization_name
    end
end
