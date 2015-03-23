require 'rails_helper'

RSpec.describe "Projects edit", type: :request do
  let(:route) { { type: :get, url: edit_project_path(organization_id: organization, id: project.id) } }

  let(:policy) { ProjectPolicy }
  let(:authorization) { :update? }

  let(:user) { create(:user) }
  let(:organization) { create(:organization) }
  let(:project) { create(:project, organization: organization) }
  
  it_behaves_like :authentication_required_route
  it_behaves_like :authorization_required_route

  it "returns a success response" do
    stub_authorization()
    get_request({})

    expect(response).to be_success
  end
end