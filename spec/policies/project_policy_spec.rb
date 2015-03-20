require "rails_helper"

describe ProjectPolicy do
  subject { ProjectPolicy.new(user, project) }

  let!(:user) { create(:user) }
  let!(:organization) { create(:organization) }
  let!(:project) { create(:project, organization: organization) }

  context "for a user that is not an admin of the organization" do
    it { should_not permit_authorization(:new) }
    it { should_not permit_authorization(:create) }
    it { should_not permit_authorization(:show) }
    it { should_not permit_authorization(:index) }
    it { should_not permit_authorization(:edit) }
    it { should_not permit_authorization(:update) }
    it { should_not permit_authorization(:destroy) }
  end

  context "for a user that is an admin of the organization" do
    before do
      Admin.create(organization: organization, user: user)
    end
    it { should permit_authorization(:new) }
    it { should permit_authorization(:create) }
    it { should permit_authorization(:show) }
    it { should permit_authorization(:index) }
    it { should permit_authorization(:edit) }
    it { should permit_authorization(:update) }
    it { should permit_authorization(:destroy) }
  end
end
