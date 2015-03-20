require 'rails_helper'

RSpec.describe "OrganizationPolicy", type: :policy do
  let(:subject) { OrganizationPolicy.new(user, organization) }
  let(:organization) { create(:organization) }
  let(:different_organization) { create(:organization) }
  let(:user) { create(:user) }

  context "user is an employee of the organization" do
    before(:each) do
      create(:employee, organization: organization, user: user)
    end

    expect_it { to permit_authorization(:view_employees) }
    expect_it { not_to permit_authorization(:create_employees) }    
  end

  context "user is an admin of the organization" do
    before(:each) do
      create(:admin, organization: organization, user: user)
    end

    expect_it { to permit_authorization(:view_employees) }
    expect_it { to permit_authorization(:create_employees) }
  end

  context "user is an admin of another organization" do
    before(:each) do
      create(:admin, organization: different_organization, user: user)
    end

    expect_it { not_to permit_authorization(:view_employees) }
    expect_it { not_to permit_authorization(:create_employees) }
  end

  context "user is an employee of another organization" do
    before(:each) do
      create(:admin, organization: different_organization, user: user)
    end

    expect_it { not_to permit_authorization(:view_employees) }
    expect_it { not_to permit_authorization(:create_employees) }
  end
end