require 'rails_helper'

RSpec.describe "Employees new", type: :request do
  let(:policy) { OrganizationPolicy }
  let(:user) { create(:user) }
  let(:organization) { create(:organization) }
  let(:route) { { type: :get, url: new_employee_path(organization_id: organization) } }
  let(:authorization) { :create_employees? }
  
  it_behaves_like :authentication_required_route
  it_behaves_like :authorization_required_route

  it "returns a success response" do
    stub_authorization()
    get_request({})

    expect(response).to be_success
  end
end