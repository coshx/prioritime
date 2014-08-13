class WeeklyProjectAssignmentsController < ApplicationController
  before_action :authenticate_user_from_token!
  before_action :set_weekly_project_assignment, only: [:show, :edit, :update, :destroy]

  # GET /weekly_project_assignments
  # GET /weekly_project_assignments.json
  def index
    @weekly_project_assignments = WeeklyProjectAssignment.for_user(current_user)

    respond_to do |format|
      format.html
      format.json { render json: @weekly_project_assignments }
    end
  end

  # GET /weekly_project_assignments/1
  # GET /weekly_project_assignments/1.json
  def show
    respond_to do |format|
      format.html
      format.json { render json: @weekly_project_assignment }
    end
  end

  # GET /weekly_project_assignments/new
  def new
    @weekly_project_assignment = WeeklyProjectAssignment.new
  end

  # GET /weekly_project_assignments/1/edit
  def edit
  end

  # POST /weekly_project_assignments
  # POST /weekly_project_assignments.json
  def create
    project_assignment = ProjectAssignment.for_user(current_user).find(params[:weekly_project_assignment][:project_assignment_id])
    @weekly_project_assignment = WeeklyProjectAssignment.new(weekly_project_assignment_params)
    @weekly_project_assignment.project_assignment = project_assignment

    respond_to do |format|
      if @weekly_project_assignment.save
        format.html { redirect_to @weekly_project_assignment, notice: 'Weekly project assignment was successfully created.' }
        format.json { render json: @weekly_project_assignment, status: :created, location: @weekly_project_assignment }
      else
        format.html { render :new }
        format.json { render json: @weekly_project_assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /weekly_project_assignments/1
  # PATCH/PUT /weekly_project_assignments/1.json
  def update
    respond_to do |format|
      if @weekly_project_assignment.update(weekly_project_assignment_params)
        format.html { redirect_to @weekly_project_assignment, notice: 'Weekly project assignment was successfully updated.' }
        format.json { render json: @weekly_project_assignment, status: :ok, location: @weekly_project_assignment }
      else
        format.html { render :edit }
        format.json { render json: @weekly_project_assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /weekly_project_assignments/1
  # DELETE /weekly_project_assignments/1.json
  def destroy
    @weekly_project_assignment.destroy
    respond_to do |format|
      format.html { redirect_to weekly_project_assignments_url, notice: 'Weekly project assignment was successfully destroyed.' }
      format.json { head :no_content }
    end
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
