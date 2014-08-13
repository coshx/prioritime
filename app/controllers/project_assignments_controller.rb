class ProjectAssignmentsController < ApplicationController
  before_action :authenticate_user_from_token!
  before_action :set_project_assignment, only: [:show, :edit, :update, :destroy]

  # GET /project_assignments
  # GET /project_assignments.json
  def index
    @project_assignments = ProjectAssignment.for_user(current_user)

    respond_to do |format|
      format.html
      format.json { render json: @project_assignments }
    end
  end

  # GET /project_assignments/1
  # GET /project_assignments/1.json
  def show
    respond_to do |format|
      format.html
      format.json { render json: @project_assignment }
    end
  end

  # GET /project_assignments/new
  def new
    @project_assignment = ProjectAssignment.new
  end

  # GET /project_assignments/1/edit
  def edit
  end

  # POST /project_assignments
  # POST /project_assignments.json
  def create
    person =  Person.where(user: current_user).find(params[:project_assignment][:person_id])
    project = Project.where(user: current_user).find(params[:project_assignment][:project_id])
    @project_assignment = ProjectAssignment.new(project_assignment_params)
    @project_assignment.person = person
    @project_assignment.project = project

    respond_to do |format|
      if @project_assignment.save
        format.html { redirect_to @project_assignment, notice: 'Project assignment was successfully created.' }
        format.json { render json: @project_assignment, status: :created, location: @project_assignment }
      else
        format.html { render :new }
        format.json { render json: @project_assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /project_assignments/1
  # PATCH/PUT /project_assignments/1.json
  def update
    respond_to do |format|
      if @project_assignment.update(project_assignment_params)
        format.html { redirect_to @project_assignment, notice: 'Project assignment was successfully updated.' }
        format.json { render json: @project_assignment, status: :ok, location: @project_assignment }
      else
        format.html { render :edit }
        format.json { render json: @project_assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /project_assignments/1
  # DELETE /project_assignments/1.json
  def destroy
    @project_assignment.destroy
    respond_to do |format|
      format.html { redirect_to project_assignments_url, notice: 'Project assignment was successfully destroyed.' }
      format.json { head :no_content }
    end
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
