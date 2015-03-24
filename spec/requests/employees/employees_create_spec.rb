require 'rails_helper'

RSpec.describe "Employees create", type: :request do
  let(:route) { { type: :post, url: employees_path(organization_id: organization) } }

  let(:policy) { OrganizationPolicy }
  let(:authorization) { :create_employees? }

  let(:user) { create(:user) }
  let(:organization) { create(:organization) }

  it_behaves_like :authentication_required_route
  it_behaves_like :authorization_required_route

  context "all params are provided" do
    it "adds the employee in the organization" do
      stub_authorization()
      post_request({ employee: { name: "Good Employee",
                                 title: "Developer",
                                 hour_capacity: 20 } })

      expect(response).to be_success
      expect(response).to be_in_json

      new_employee_response = json(response.body)[:employee]
      expect(new_employee_response[:id]).to eql(Employee.last.id)
      expect(organization.employees.last.name).to eql("Good Employee")
    end
  end

  context "insufficient params" do
    it "returns the errors" do
      stub_authorization()
      post_request({ employee: { name: "Good Employee", title: nil, hour_capacity: 20 } })

      expect(response).to be_unprocessable_entity
      expect(response).to be_in_json

      errors = json(response.body)
      expect(errors[:title]).to be_present
    end
  end
end
