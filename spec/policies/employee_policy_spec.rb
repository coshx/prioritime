require 'rails_helper'

RSpec.describe "EmployeePolicy", type: :policy do
  let(:subject) { EmployeePolicy.new(current_user, employee) }  
  let(:organization) { create(:organization) }
  let(:different_organization) { create(:organization) }
  let(:current_user) { create(:user) }
  let(:employee_user) { create(:user) }
  let(:coworker) { create(:employee, user: create(:user), organization: organization) }

  context "user is an admin of the employee's organization" do
    let(:employee) { create(:employee, user: employee_user, organization: organization) }

    before do
      create(:admin, organization: organization, user: current_user)
    end

    expect_it { to permit_authorization(:update) }
    expect_it { to permit_authorization(:destroy) }
  end

  context "user is the employee himself" do
    let(:employee) { create(:employee, user: current_user, organization: organization) }

    expect_it { to permit_authorization(:update) }
    expect_it { not_to permit_authorization(:destroy) }
  end

  context "user is a coworker of the employee" do
    let(:employee) { create(:employee, user: employee_user, organization: organization) }

    before do
      create(:employee, organization: organization, user: current_user)
    end

    expect_it { not_to permit_authorization(:update) }
    expect_it { not_to permit_authorization(:destroy) }
  end
end