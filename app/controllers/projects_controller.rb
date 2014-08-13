class ProjectsController < ApplicationController
  before_action :authenticate_user_from_token!
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects.json
  def index
    @projects = Project.where(user_id: current_user.id)

    render json: @projects, status: 200
  end

  # GET /projects/1.json
  def show
    render json: @project, status: 200
  end

  # POST /projects.json
  def create
    @project = Project.new(project_params)
    @project.user = current_user

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
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.where(user_id: current_user.id).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :description, :duration_weeks, :start_date, :client)
    end
end
