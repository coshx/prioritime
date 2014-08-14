class PeopleController < ApplicationController
  before_action :authenticate_user_from_token!
  before_action :set_person, only: [:show, :edit, :update, :destroy]

  # GET /people.json
  def index
    @people = Person.includes(:project_assignments)
                    .includes(:projects)
                    .includes(:weekly_project_assignments)
                    .where(user_id: current_user.id)

    render json: @people, status: 200
  end

  # GET /people/1.json
  def show
    render json: @person, status: 200
  end

  # POST /people.json
  def create
    @person = Person.new(person_params)
    @person.user = current_user

    if @person.save
      render json: @person, status: :created
    else
      render json: @person.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /people/1.json
  def update
    if @person.update(person_params)
      render json: @person, status: 200
    else
      render json: @person.errors, status: :unprocessable_entity
    end
  end

  # DELETE /people/1.json
  def destroy
    @person.destroy
    head :no_content
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.where(user_id: current_user.id).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      params.require(:person).permit(:name, :title, :description, :hour_capacity)
    end
end
