require 'rails_helper'

RSpec.describe ProjectAssignmentsController, :type => :controller do
  let(:user) { create :user }
  let(:project) { create :project, user: user }
  let(:person) { create :person, user: user }
  let(:person2) { create :person, user: user }

  describe "GET index" do
    context "user not logged in" do
      it "give a not authorized error" do
        get :index, format: :json
        expect(response).to_not be_success
        expect(response.code).to eq("401")
      end
    end

    context "user signed in" do
      let!(:project_assignment1) { create :project_assignment, project: project, person: person }
      let!(:project_assignment2) { create :project_assignment, project: project, person: person2 }
      let!(:other_project_assignment) { create :project_assignment }

      before { sign_in user }

      it "gets the project_assignments of the signed in user" do
        get :index, format: :json
        expect(assigns(:project_assignments).count).to eq(2)
        expect(assigns(:project_assignments)).to_not include(other_project_assignment)
      end
    end

  end

  describe "GET show" do
    before { sign_in user }
    let(:project_assignment) { create :project_assignment, project: project, person: person }

    it "gets the project assignment specifed" do
      get :show, format: :json, id: project_assignment.id
      expect(assigns(:project_assignment)).to eq(project_assignment)
    end
  end

  describe "POST create" do
    before { sign_in user }

    it "creates a new project_assignment for the project and person specified" do
      expect {
        post :create, format: :json, project_assignment: { project_id: project.id, person_id: person.id, summary: "Worker" }
      }.to change{ProjectAssignment.count}.by(1)

      expect(user.project_assignments.last).to eq(ProjectAssignment.last)
    end
  end

  describe "PUT update" do
    before { sign_in user }
    let(:project_assignment) { create :project_assignment, project: project, person: person }

    it "lets you update the project_assignment" do
      put :update, format: :json, id: project_assignment.id, project_assignment: { summary: "Updated work assignment" }
      p = user.project_assignments.last
      expect(p.summary).to eq("Updated work assignment")
    end
  end

  describe "DELETE destroy" do
    before { sign_in user }
    let!(:project_assignment) { create :project_assignment, project: project, person: person }

    it "lets you delete a project_assignment" do
      expect {
        delete :destroy, format: :json, id: project_assignment.id
      }.to change{ProjectAssignment.count}.by(-1)

      expect(ProjectAssignment.where(id: project_assignment.id)).to be_empty
    end
  end

end
