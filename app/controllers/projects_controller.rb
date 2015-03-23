class ProjectsController < ApplicationController
  before_action :authenticate_user_from_token!, :find_organization
  before_action :find_project, only: [:edit, :update, :destroy]
  after_action :verify_authorized

  # GET 1/projects.json
  def index
    authorize @organization, :view_projects?

    projects = @organization.projects
    render json: projects, status: 200
  end

  # GET 1/projects/new.json
  def new
    authorize @organization, :create_projects?
    head :no_content
  end

  # POST 1/projects.json
  def create
    authorize @organization, :create_projects?
    
    project = Project.new(project_params)
    project.organization_id = @organization.id

    if project.save
      render json: project, status: :created
    else
      render json: project.errors, status: :unprocessable_entity
    end
  end

  # GET 1/projects/1/edit.json
  def edit
    authorize @project, :update?
    head :no_content
  end

  # PATCH/PUT 1/projects/1.json
  def update
    authorize @project, :update?

    if @project.update(project_params)
      render json: @project, status: 200
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  # DELETE 1/projects/1.json
  def destroy
    authorize @project, :destroy?
    @project.destroy
    head :no_content
  end

  private
    def find_organization
      @organization = Organization.find(params[:organization_id])
    end

    def find_project
      @project = Project.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:name, :description, :duration_weeks,
                                      :start_date, :client)
    end
end
