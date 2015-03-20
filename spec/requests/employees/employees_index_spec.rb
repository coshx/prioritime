require 'rails_helper'

RSpec.describe "Employees index", type: :request do
  let(:policy) { OrganizationPolicy }
  let(:user) { create(:user) }
  let(:organization) { create(:organization) }
  let(:different_organization) { create(:organization) }
  let(:route) { { type: :get, url: employees_path(organization_id: organization) } }
  let(:authorization) { :view_employees? }
  
  let!(:employee1) { create(:employee, organization: organization) }
  let!(:employee2) { create(:employee, organization: organization) }
  let!(:other_employee) { create(:employee, organization: different_organization) }

  it_behaves_like :authentication_required_route
  it_behaves_like :authorization_required_route

  it "returns the employees of the organization" do
    stub_authorization()
    get_request({})

    expect(response).to be_success
    expect(response).to be_in_json
  
    employees_response = json(response.body)[:employees]
    expect(employees_response.count).to eq(2)
    expect(employees_response.last[:id]).to eql(employee2.id)
    expect(employees_response.first[:id]).to eql(employee1.id)
  end
end