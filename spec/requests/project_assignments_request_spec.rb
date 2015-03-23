require 'rails_helper'

describe ProjectAssignmentsController do
  let(:user) { create :user }
  let(:project) { create :project }

=begin
  describe "GET index" do
    let(:route) { { type: :get, url: project_assignments_path } }

    it_behaves_like :authentication_required_route

    context "user signed in" do
      let!(:project_assignment1) { create :project_assignment, project: project }
      let!(:project_assignment2) { create :project_assignment, project: project }
      let!(:other_project_assignment) { create :project_assignment }

      it "gets the project_assignments of the signed in user" do
        get(route[:url], {}, authenticated_json_header(user))

        expect(response).to be_success
        expect(response).to be_in_json

        project_assignments_response = json(response.body)[:project_assignments]
        expect(project_assignments_response.count).to eq(2)
        expect(project_assignments_response.first[:id]).to eq(project_assignment2.id)
        expect(project_assignments_response.last[:id]).to eq(project_assignment1.id)
      end
    end
  end

  describe "GET for_person" do
    let(:route) { { type: :get, url: for_person_project_assignments_path(person_id: person.id) } }

    it_behaves_like :authentication_required_route

    context "user signed in" do
      let!(:project_assignment1) { create :project_assignment, project: project, person: person }
      let!(:project_assignment2) { create :project_assignment, project: project, person: person2 }
      let!(:other_project_assignment) { create :project_assignment }

      it "gets the project_assignments for specified person" do
        get(route[:url], {}, authenticated_json_header(user))

        expect(response).to be_success
        expect(response).to be_in_json

        project_assignments_response = json(response.body)[:project_assignments]
        expect(project_assignments_response.count).to eq(1)
        expect(project_assignments_response.first[:id]).to eq(project_assignment1.id)
      end
    end    
  end

  describe "GET show" do
    let(:project_assignment) { create :project_assignment, person: person, project: project }
    let(:route) { { type: :get, url: project_assignment_path(project_assignment)}}

    it_behaves_like :authentication_required_route

    it "gets the user specifed" do
      get(route[:url], {}, authenticated_json_header(user))

      expect(response).to be_success
      expect(response).to be_in_json

      project_assignment_response = json(response.body)[:project_assignment]
      expect(project_assignment_response[:id]).to eql(project_assignment.id)
    end
  end

  describe "POST create" do
    let(:route) { { type: :post, url: project_assignments_path } }

    it_behaves_like :authentication_required_route

    it "creates a new project_assignment for the user" do
      post(route[:url], { project_assignment: { project_id: project.id, 
        person_id: person.id, summary: "Worker" } }, 
        authenticated_json_header(user))

      expect(response).to be_success
      expect(response).to be_in_json

      new_project_assignment_response = json(response.body)[:project_assignment]
      expect(new_project_assignment_response[:summary]).to eql("Worker")
      expect(user.project_assignments.last.summary).to eql("Worker")      
    end
  end

  describe "PUT update" do
    let(:project_assignment) { create :project_assignment, person: person, project: project }
    let(:route) { { type: :patch, url: project_assignment_path(project_assignment) } }

    it_behaves_like :authentication_required_route

    it "lets you update the project_assignment" do
      patch(route[:url], { project_assignment: { summary: "Strange project_assignment" } }, 
        authenticated_json_header(user))

      expect(response).to be_success
      expect(response).to be_in_json

      updated_project_assignment_response = json(response.body)[:project_assignment]
      expect(updated_project_assignment_response[:summary]).to eql("Strange project_assignment")

      p = user.project_assignments.last
      expect(p.summary).to eq("Strange project_assignment")
    end
  end

  describe "DELETE destroy" do
    let(:route) { { type: :delete, url: project_assignment_path(id: project_assignment.id) } }
    let!(:project_assignment) { create :project_assignment, project: project }

    it_behaves_like :authentication_required_route

    it "lets you delete a project_assignment" do
      delete(route[:url], {}, authenticated_json_header(user))

      expect(response).to be_success

      expect(ProjectAssignment.where(id: project_assignment.id)).to be_empty
    end
  end
=end
end
