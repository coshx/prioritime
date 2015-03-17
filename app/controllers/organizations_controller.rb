class OrganizationsController < ApplicationController
  before_action :authenticate_user_from_token!

  def dashboard
    @organization = Organization.find(params[:id])
                                # .includes(:project_assignments)
                                # .includes(:projects)
                                # .includes(:weekly_project_assignments)

    render json: @organization, status: 200
  end
end