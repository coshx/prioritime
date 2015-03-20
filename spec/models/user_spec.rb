require 'rails_helper'

RSpec.describe User, :type => :model do
  describe "Associations" do
    expect_it { to have_many(:roles).dependent(:destroy) }
  end

  describe "Role-related methods" do
    let(:organization) { create(:organization) }
    let(:different_organization) { create(:organization) }
  
    describe "admin_of?(organization)" do
      subject { user.admin_of?(organization) }

      context "user is an admin of the organization" do
        let(:user) { create(:user, roles: [ create(:admin, organization: organization) ]) }
        expect_it { to be_truthy }
      end

      context "user is an employee(not an admin) of the organization" do
        let(:user) { create(:user, roles: [ create(:employee, organization: organization) ]) }
        expect_it { to be_falsey }
      end

      context "user is an admin of different organization" do
        let(:user) { create(:user, roles: [ create(:admin, organization: different_organization) ]) }
        expect_it { to be_falsey }
      end
    end # admin_of?(organization)

    describe "part_of?(organizaiton)" do
      subject { user.part_of?(organization)}

      context "user is an admin of the organization" do
        let(:user) { create(:user, roles: [ create(:admin, organization: organization) ]) }
        expect_it { to be_truthy }
      end

      context "user is an employee of the organization" do
        let(:user) { create(:user, roles: [ create(:employee, organization: organization) ]) }
        expect_it { to be_truthy }
      end

      context "user is an admin of different organization" do
        let(:user) { create(:user, roles: [ create(:admin, organization: different_organization) ]) }
        expect_it { to be_falsey }
      end
    end # part_of?(organizaiton)
  end # Role-related methods

  describe "Callbacks" do
    describe "set_authentication_token" do
      context "authentication_token is not set" do
        let(:user) { build(:user) }
        
        it "sets unique authentication_token" do
          existing_user = create(:user)
          expect(SecureRandom).to receive(:hex).and_return(existing_user.authentication_token).exactly(1).times
          expect(SecureRandom).to receive(:hex).and_return("something_random")
          user.save
          expect(user.authentication_token).not_to equal(existing_user.authentication_token)
        end
      end

      context "authentication_token is set" do
        it "does not do anything" do
          user = create(:user, authentication_token: 'token')
          expect(user.authentication_token).to eql('token')
        end
      end
    end # set_authentication_token
  end # Callbacks
end
