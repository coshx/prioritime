require 'rails_helper'

RSpec.describe "Projects index", type: :request do
  let(:route) { { type: :get, url: projects_path(organization_id: organization) } }

  let(:policy) { OrganizationPolicy }
  let(:authorization) { :view_projects? }

  let!(:organization) { create(:organization) }
  let!(:user) { create(:user) }

  let!(:project1) { create :project, organization: organization }
  let!(:project2) { create :project, organization: organization }
  let!(:other_project) { create :project }
  
  it_behaves_like :authentication_required_route
  it_behaves_like :authorization_required_route


  it "returns the projects of the organization in json" do
    stub_authorization()
    get_request({})

    expect(response).to be_success
    expect(response).to be_in_json

    projects_response = json(response.body)[:projects] 
    project_ids = projects_response.map { |p| p[:id] }
    expect(project_ids).to eq [project1.id, project2.id]
  end
end