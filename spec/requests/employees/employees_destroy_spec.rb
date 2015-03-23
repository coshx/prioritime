require 'rails_helper'

RSpec.describe "Employees destroy", type: :request do
  let(:policy) { EmployeePolicy }
  let(:user) { create(:user) }
  let(:employee) { create(:employee, user: user, organization: organization) }
  let(:organization) { create(:organization) }
  let(:route) { { type: :delete, url: employee_path(organization_id: organization, id: employee.id) } }
  let(:authorization) { :destroy? }
  
  it_behaves_like :authentication_required_route
  it_behaves_like :authorization_required_route

  it "deletes the employee" do
    stub_authorization()
    delete_request({})

    expect(response).to be_success
    expect(Employee.last).to be_nil
  end
end