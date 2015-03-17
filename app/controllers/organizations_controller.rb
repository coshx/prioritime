class OrganizationsController < ApplicationController
  before_action :authenticate_user_from_token!, :find_organization, :authorize_user

  def dashboard
    render json: @organization, status: 200
  end

  private

    def find_organization
      @organization = Organization.find(params[:id])
    end

    def authorize_user
      authorize @organization, :view?
    end
end