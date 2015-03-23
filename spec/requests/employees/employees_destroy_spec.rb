require 'rails_helper'

RSpec.describe "Employees destroy", type: :request do
  let(:route) { { type: :delete, url: employee_path(organization_id: organization, id: employee.id) } }

  let(:policy) { EmployeePolicy }
  let(:authorization) { :destroy? }

  let(:user) { create(:user) }
  let(:organization) { create(:organization) }

  let(:employee) { create(:employee, user: user, organization: organization) }
  
  it_behaves_like :authentication_required_route
  it_behaves_like :authorization_required_route

  it "deletes the employee" do
    stub_authorization()
    delete_request({})

    expect(response).to be_success
    expect(Employee.last).to be_nil
  end
end