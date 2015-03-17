require 'rails_helper'

RSpec.describe "Organization dashboard", type: :request do
  let(:policy) { OrganizationPolicy }
  let(:user) { create(:user) }
  let(:organization) { create(:organization) }
  let(:route) { { type: :get, url: dashboard_organization_path(organization) } }
  let(:authorization) { :view? }
  
  it_behaves_like :authentication_required_route
  it_behaves_like :authorization_required_route
  
  it "returns the organization" do
    stub_authorization()
    get_request({})

    expect(response).to be_success
    expect(response).to be_in_json

    organization_response = json(response.body)[:organization]
    expect(organization_response[:name]).to eq(organization.name)
  end
end