class EmployeesController < ApplicationController
  before_action :authenticate_user_from_token!, :find_organization
  before_action :find_employee, only: [:edit, :update, :destroy]
  after_action :verify_authorized

  # GET 1/employees.json
  def index
    authorize @organization, :view_employees?

    employees = @organization.employees
    render json: employees, status: 200
  end

  # GET 1/employees/new.json
  def new
    authorize @organization, :create_employees?
    head :no_content
  end

  # POST 1/employees.json
  def create
    authorize @organization, :create_employees?

    employee = Employee.new(employee_params)
    employee.organization_id = @organization.id
    employee.user_id = current_user.id

    if employee.save
      employee.send_invitation_to(params[:employee][:email])
      render json: employee, status: :created
    else
      render json: employee.errors, status: :unprocessable_entity
    end
  end

  # GET 1/employees/1/edit.json
  def edit
    authorize @employee, :update?
    head :no_content
  end

  # PATCH/PUT 1/employees/1.json
  def update
    authorize @employee, :update?

    if @employee.update(employee_params)
      render json: @employee, status: 200
    else
      render json: @employee.errors, status: :unprocessable_entity
    end
  end

  # DELETE 1/employees/1.json
  def destroy
    authorize @employee, :destroy?
    @employee.destroy
    head :no_content
  end

  private
    def find_organization
      @organization = Organization.find(params[:organization_id])
    end

    def find_employee
      @employee = Employee.find(params[:id])
    end

    def employee_params
      params.require(:employee).permit(:name, :title, :hour_capacity)
    end
end
