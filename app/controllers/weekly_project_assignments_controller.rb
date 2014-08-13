class WeeklyProjectAssignmentsController < ApplicationController
  before_action :authenticate_user_from_token!
  before_action :set_weekly_project_assignment, only: [:show, :edit, :update, :destroy]

  # GET /weekly_project_assignments.json
  def index
    @weekly_project_assignments = WeeklyProjectAssignment.for_user(current_user)
    render json: @weekly_project_assignments
  end

  # GET /weekly_project_assignments/1.json
  def show
    render json: @weekly_project_assignment
  end

  # POST /weekly_project_assignments.json
  def create
    project_assignment = ProjectAssignment.for_user(current_user).find(params[:weekly_project_assignment][:project_assignment_id])
    @weekly_project_assignment = WeeklyProjectAssignment.new(weekly_project_assignment_params)
    @weekly_project_assignment.project_assignment = project_assignment

    if @weekly_project_assignment.save
      render json: @weekly_project_assignment, status: :created
    else
      render json: @weekly_project_assignment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /weekly_project_assignments/1.json
  def update
    if @weekly_project_assignment.update(weekly_project_assignment_params)
      render json: @weekly_project_assignment, status: 200
    else
      render json: @weekly_project_assignment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /weekly_project_assignments/1.json
  def destroy
    @weekly_project_assignment.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_weekly_project_assignment
      @weekly_project_assignment = WeeklyProjectAssignment.for_user(current_user).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def weekly_project_assignment_params
      params.require(:weekly_project_assignment).permit(:week_start, :days_working)
    end
end
