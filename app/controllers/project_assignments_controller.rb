class ProjectAssignmentsController < ApplicationController
  before_action :authenticate_user_from_token!
  before_action :set_project_assignment, only: [:show, :edit, :update, :destroy]

  # GET /project_assignments.json
  def index
    @project_assignments = ProjectAssignment.for_user(current_user)
    render json: @project_assignments, status: 200
  end

  # GET /project_assignments/1.json
  def show
    render json: @project_assignment
  end

  # GET /project_assignments/for_person/1.json
  def for_person
    render json: ProjectAssignment.where(person_id: params[:person_id]), status: 200
  end

  # POST /project_assignments.json
  def create
    person_id = params[:project_assignment][:person_id]
    person_id ||= params[:project_assignment][:person][:id]
    project_id = params[:project_assignment][:project_id]
    project_id ||= params[:project_assignment][:project][:id]

    person =  Person.where(user: current_user).find(person_id)
    project = Project.where(user: current_user).find(project_id)

    @project_assignment = ProjectAssignment.new(project_assignment_params)
    @project_assignment.person = person
    @project_assignment.project = project

    if @project_assignment.save
      render json: @project_assignment, status: :created
    else
      render json: @project_assignment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /project_assignments/1.json
  def update
    if @project_assignment.update(project_assignment_params)
      render json: @project_assignment, status: 200
    else
      render json: @project_assignment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /project_assignments/1.json
  def destroy
    @project_assignment.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project_assignment
      # join over to projects to make sure the project belongs to the user
      @project_assignment = ProjectAssignment.for_user(current_user).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_assignment_params
      params.require(:project_assignment).permit(:summary)
    end
end
