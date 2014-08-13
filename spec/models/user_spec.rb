require 'rails_helper'

RSpec.describe User, :type => :model do
  describe "associations" do
    expect_it { to have_many(:people).dependent(:destroy) }
    expect_it { to have_many(:projects).dependent(:destroy) }
    expect_it { to have_many(:project_assignments).through(:projects) }
    expect_it { to have_many(:weekly_project_assignments).through(:project_assignments) }
  end

  describe "callbacks" do
    describe "set_authentication_token" do
      context "authentication_token is not set" do
        let(:user) { build(:user) }
        
        it "sets unique authentication_token" do
          existing_user = create(:user)
          expect(SecureRandom).to receive(:hex).and_return(existing_user.authentication_token).exactly(1).times
          expect(SecureRandom).to receive(:hex).and_return("something_random")
          user.stub(:connect_with_validic)
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
  end

end
