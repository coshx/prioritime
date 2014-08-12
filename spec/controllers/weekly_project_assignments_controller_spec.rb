require 'rails_helper'

RSpec.describe WeeklyProjectAssignmentsController, :type => :controller do
  let(:user) { create :user }
  let(:project) { create :project, user: user }
  let(:person) { create :person, user: user }
  let(:person2) { create :person, user: user }
  let(:project_assignment) { create :project_assignment, person: person, project: project }

  describe "GET index" do
    context "user not logged in" do
      it "give a not authorized error" do
        get :index, format: :json
        expect(response).to_not be_success
        expect(response.code).to eq("401")
      end
    end

    context "user signed in" do
      let!(:weekly_project_assignment1) { create :weekly_project_assignment, project_assignment: project_assignment }
      let!(:weekly_project_assignment2) { create :weekly_project_assignment, project_assignment: project_assignment, week_start: 4.weeks.from_now.to_date.at_beginning_of_week }
      let!(:other_weekly_project_assignment) { create :weekly_project_assignment }

      before { sign_in user }

      it "gets the weekly_project_assignments of the signed in user" do
        get :index, format: :json
        expect(assigns(:weekly_project_assignments).count).to eq(2)
        expect(assigns(:weekly_project_assignments)).to_not include(other_weekly_project_assignment)
      end
    end

  end

  describe "GET show" do
    before { sign_in user }
    let(:weekly_project_assignment) { create :weekly_project_assignment, project_assignment: project_assignment }

    it "gets the project assignment specifed" do
      get :show, format: :json, id: weekly_project_assignment.id
      expect(assigns(:weekly_project_assignment)).to eq(weekly_project_assignment)
    end
  end

  describe "POST create" do
    before { sign_in user }

    it "creates a new weekly_project_assignment for the project and person specified" do
      expect {
        post :create, format: :json, weekly_project_assignment: { project_assignment_id: project_assignment.id, week_start: 4.weeks.from_now.to_date.at_beginning_of_week, days_working: 5 }
      }.to change{WeeklyProjectAssignment.count}.by(1)

      expect(user.weekly_project_assignments.last).to eq(WeeklyProjectAssignment.last)
    end
  end

  describe "PUT update" do
    before { sign_in user }
    let(:weekly_project_assignment) { create :weekly_project_assignment, project_assignment: project_assignment }

    it "lets you update the weekly_project_assignment" do
      put :update, format: :json, id: weekly_project_assignment.id, weekly_project_assignment: { days_working: "5" }
      p = user.weekly_project_assignments.last
      expect(p.days_working).to eq(5)
    end
  end

  describe "DELETE destroy" do
    before { sign_in user }
    let!(:weekly_project_assignment) { create :weekly_project_assignment, project_assignment: project_assignment }

    it "lets you delete a weekly_project_assignment" do
      expect {
        delete :destroy, format: :json, id: weekly_project_assignment.id
      }.to change{WeeklyProjectAssignment.count}.by(-1)

      expect(WeeklyProjectAssignment.where(id: weekly_project_assignment.id)).to be_empty
    end
  end

end
