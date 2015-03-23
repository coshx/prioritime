require 'rails_helper'

RSpec.describe "Projects create", type: :request do
  let(:route) { { type: :post, url: projects_path(organization_id: organization) } }

  let(:policy) { OrganizationPolicy }
  let(:authorization) { :create_projects? }

  let(:user) { create(:user) }
  let(:organization) { create(:organization) }
  
  it_behaves_like :authentication_required_route
  it_behaves_like :authorization_required_route

  context "all params are provided" do
    it "adds the project in the organization" do
      stub_authorization()
      post_request({ project: { name: "Good project", client: "Good client" } })

      expect(response).to be_success
      expect(response).to be_in_json
    
      new_project_response = json(response.body)[:project]
      expect(new_project_response[:id]).to eql(Project.last.id)
      expect(organization.projects.last.name).to eql("Good project")
    end
  end

  context "insufficient params" do
    it "returns the errors" do
      stub_authorization()
      post_request({ project: { client: "Good client" } })

      expect(response).to be_unprocessable_entity
      expect(response).to be_in_json
    
      errors = json(response.body)
      expect(errors[:name]).to be_present
    end
  end
end