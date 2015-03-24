require 'rails_helper'

RSpec.describe "Employees update", type: :request do
  let(:route) { { type: :patch, url: employee_path(organization_id: organization, id: employee.id) } }

  let(:policy) { EmployeePolicy }
  let(:authorization) { :update? }

  let(:user) { create(:user) }
  let(:organization) { create(:organization) }

  let(:employee) { create(:employee, user: user, organization: organization) }
  
  it_behaves_like :authentication_required_route
  it_behaves_like :authorization_required_route

  context "all params are provided" do
    it "updates the employee" do
      stub_authorization()
      patch_request({ employee: { name: "Good Employee", title: "Developer", hour_capacity: 20 } })

      expect(response).to be_success
      expect(response).to be_in_json
    
      employee.reload
      employee_response = json(response.body)[:employee]
      expect(employee_response[:id]).to eql(employee.id)
      expect(employee.name).to eql("Good Employee")
    end
  end

  context "insufficient params" do
    it "returns the errors" do
      stub_authorization()
      patch_request({ employee: { name: nil, title: "Developer", hour_capacity: 20 } })

      expect(response).to be_unprocessable_entity
      expect(response).to be_in_json
    
      errors = json(response.body)
      expect(errors[:name]).to be_present
    end
  end
end