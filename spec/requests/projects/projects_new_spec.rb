require 'rails_helper'

RSpec.describe "Projects new", type: :request do
  let(:route) { { type: :get, url: new_project_path(organization_id: organization) } }

  let(:policy) { OrganizationPolicy }
  let(:authorization) { :create_projects? }

  let(:user) { create(:user) }
  let(:organization) { create(:organization) }
  
  it_behaves_like :authentication_required_route
  it_behaves_like :authorization_required_route

  it "returns a success response" do
    stub_authorization()
    get_request({})

    expect(response).to be_success
  end
end