require 'rails_helper'

describe WeeklyProjectAssignmentsController do
  let(:user) { create :user }
  let(:project) { create :project, user: user }
  let(:person) { create :person, user: user }
  let(:person2) { create :person, user: user }
  let(:project_assignment) { create :project_assignment, person: person, project: project }

  describe "GET index" do
    let(:route) { { type: :get, url: weekly_project_assignments_path } }

    it_behaves_like :authentication_required_route

    context "user signed in" do
      let!(:weekly_project_assignment1) { create :weekly_project_assignment, project_assignment: project_assignment }
      let!(:weekly_project_assignment2) { create :weekly_project_assignment, project_assignment: project_assignment, week_start: 4.weeks.from_now.to_date.at_beginning_of_week }
      let!(:other_weekly_project_assignment) { create :weekly_project_assignment }

      it "gets the weekly_project_assignments of the signed in user" do
        get(route[:url], {}, authenticated_json_header(user))

        expect(response).to be_success
        expect(response).to be_in_json

        weekly_project_assignments_response = json(response.body)[:weekly_project_assignments]
        expect(weekly_project_assignments_response.count).to eq(2)
        expect(weekly_project_assignments_response.first[:id]).to eq(weekly_project_assignment2.id)
        expect(weekly_project_assignments_response.last[:id]).to eq(weekly_project_assignment1.id)
      end
    end
  end

  describe "GET show" do
    let(:weekly_project_assignment) { create :weekly_project_assignment, project_assignment: project_assignment }
    let(:route) { { type: :get, url: weekly_project_assignment_path(weekly_project_assignment) } }

    it_behaves_like :authentication_required_route

    it "gets the user specifed" do
      get(route[:url], {}, authenticated_json_header(user))

      expect(response).to be_success
      expect(response).to be_in_json

      weekly_project_assignment_response = json(response.body)[:weekly_project_assignment]
      expect(weekly_project_assignment_response[:id]).to eql(weekly_project_assignment.id)
    end
  end

  describe "POST create" do
    let(:route) { { type: :post, url: weekly_project_assignments_path } }

    it_behaves_like :authentication_required_route

    it "creates a new weekly_project_assignment for the user" do
      post(route[:url], { weekly_project_assignment: { project_assignment_id: project_assignment.id, 
        week_start: 4.weeks.from_now.to_date.at_beginning_of_week, 
        days_working: 5 } }, 
        authenticated_json_header(user))

      expect(response).to be_success
      expect(response).to be_in_json

      new_weekly_project_assignment_response = json(response.body)[:weekly_project_assignment]
      expect(new_weekly_project_assignment_response[:days_working]).to eql(5)
      expect(user.weekly_project_assignments.last.days_working).to eql(5)      
    end
  end

  describe "PUT update" do
    let(:weekly_project_assignment) { create :weekly_project_assignment, project_assignment: project_assignment }
    let(:route) { { type: :patch, url: weekly_project_assignment_path(weekly_project_assignment) } }

    it_behaves_like :authentication_required_route

    it "lets you update the weekly_project_assignment" do
      patch(route[:url], { weekly_project_assignment: { days_working: "4" } }, 
        authenticated_json_header(user))

      expect(response).to be_success
      expect(response).to be_in_json

      updated_weekly_project_assignment_response = json(response.body)[:weekly_project_assignment]
      expect(updated_weekly_project_assignment_response[:days_working]).to eql(4)
      p = user.weekly_project_assignments.last
      expect(p.days_working).to eq(4)
    end
  end

  describe "DELETE destroy" do
    let(:route) { { type: :delete, url: weekly_project_assignment_path(id: weekly_project_assignment.id) } }
    let!(:weekly_project_assignment) { create :weekly_project_assignment, project_assignment: project_assignment}

    it_behaves_like :authentication_required_route

    it "lets you delete a weekly_project_assignment" do
      delete(route[:url], {}, authenticated_json_header(user))

      expect(response).to be_success

      expect(WeeklyProjectAssignment.where(id: weekly_project_assignment.id)).to be_empty
    end
  end
end
