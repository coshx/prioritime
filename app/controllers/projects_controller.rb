class ProjectsController < ApplicationController
  before_action :authenticate_user_from_token!
  after_filter :verify_authorized, except: [:index]
  before_action :load_and_authorize_resource, except: [:index]
  before_action :load_and_authorize_scope, only: :index

  # GET /projects.json
  def index
    render json: @projects, status: 200
  end

  # GET /projects/1.json
  def show
    render json: @project, status: 200
  end

  # POST /projects.json
  def create
    if @project.save
      render json: @project, status: :created
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /projects/1.json
  def update
    if @project.update(project_params)
      render json: @project, status: 200
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  # DELETE /projects/1.json
  def destroy
    @project.destroy
    head :no_content
  end

  private

    def load_and_authorize_resource
      if params[:id]
        @project = Project.find(params[:id])
      else
        @project = Project.new(project_params)
        @project.organization_id = params[:organization_id]
      end
      authorize @project
    end

    def load_and_authorize_scope
      organization = Organization.find(params[:organization_id])
      unless organization.can_user_access?(current_user)
        raise Pundit::NotAuthorizedError
      end
      @projects = organization.projects
    end

    def project_params
      params.require(:project).permit(:name, :description, :duration_weeks,
                                      :start_date, :client)
    end
end
