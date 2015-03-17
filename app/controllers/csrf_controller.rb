class CsrfController < ApplicationController
  # skip_before_filter :authenticate_user!
  # before_filter :authenticate_user_from_token!
  
  def index
    render json: { request_forgery_protection_token => form_authenticity_token }.to_json
  end
end