class EmployeesController < ApplicationController
  before_action :authenticate_user_from_token!, :find_organization
  before_action :find_employee, :authorize_user, only: [:show, :edit, :update, :destroy]

  # GET /employees.json
  def index
    authorize @organization, :view?

    @employees = @organization.employees
    render json: @employees, status: 200
  end

  # # GET /employees/1.json
  # def show
  #   render json: @person, status: 200
  # end

  # # POST /employees.json
  # def create
  #   @person = Person.new(person_params)
  #   @person.user = current_user

  #   if @person.save
  #     render json: @person, status: :created
  #   else
  #     render json: @person.errors, status: :unprocessable_entity
  #   end
  # end

  # # PATCH/PUT /employees/1.json
  # def update
  #   if @person.update(person_params)
  #     render json: @person, status: 200
  #   else
  #     render json: @person.errors, status: :unprocessable_entity
  #   end
  # end

  # # DELETE /employees/1.json
  # def destroy
  #   @person.destroy
  #   head :no_content
  # end

  private
    def find_organization
      @organization = Organization.find(params[:organization_id])
    end

    def find_employee
      @employee = Employee.find(params[:id])
    end

    def authorize_user
      authorize @employee, :manage?
    end

    def person_params
      params.require(:person).permit(:name, :title, :description, :hour_capacity)
    end
end
