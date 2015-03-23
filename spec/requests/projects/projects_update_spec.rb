require 'rails_helper'

RSpec.describe "Projects update", type: :request do
  let(:route) { { type: :patch, url: project_path(organization_id: organization, id: project.id) } }

  let(:policy) { ProjectPolicy }
  let(:authorization) { :update? }

  let(:user) { create(:user) }
  let(:organization) { create(:organization) }

  let(:project) { create(:project, organization: organization) }
  
  it_behaves_like :authentication_required_route
  it_behaves_like :authorization_required_route

  context "all params are provided" do
    it "updates the project and returns it in json" do
      stub_authorization()
      patch_request({ project: { name: "Good project", client: "Good client" } })

      expect(response).to be_success
      expect(response).to be_in_json
    
      project.reload
      project_response = json(response.body)[:project]
      expect(project_response[:id]).to eql(project.id)
      expect(project.name).to eql("Good project")
    end
  end

  context "insufficient params" do
    it "returns the errors" do
      stub_authorization()
      patch_request({ project: { name: nil, client: "Good client" } })

      expect(response).to be_unprocessable_entity
      expect(response).to be_in_json
    
      errors = json(response.body)
      expect(errors[:name]).to be_present
    end
  end
end