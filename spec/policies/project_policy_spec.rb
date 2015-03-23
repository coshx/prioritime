require "rails_helper"

describe ProjectPolicy do
  subject { ProjectPolicy.new(user, project) }

  let(:user) { create(:user) }
  let(:organization) { create(:organization) }
  let(:project) { create(:project, organization: organization) }

  context "user is not an admin of the organization" do
    expect_it { not_to permit_authorization(:update) }
    expect_it { not_to permit_authorization(:destroy) }
  end

  context "user is an admin of the organization" do
    before(:each) do
      create(:admin, organization: organization, user: user)
    end

    expect_it { to permit_authorization(:update) }
    expect_it { to permit_authorization(:destroy) }
  end
end
