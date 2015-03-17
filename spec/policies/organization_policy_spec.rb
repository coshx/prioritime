require 'rails_helper'

RSpec.describe "OrganizationPolicy", type: :policy do
  let(:subject) { OrganizationPolicy.new(user, organization) }
  let(:organization) { create(:organization) }

  describe "view?" do
    context "has role in the organization" do
      let(:user) { create(:user) }
      let!(:employee) { create(:employee, user: user, organization: organization)}

      expect_it { to authorize(:view) }
    end

    context "does not have role in the organization" do
      let(:user) { create(:user) }
      expect_it { not_to authorize(:view) }      
    end
  end
end