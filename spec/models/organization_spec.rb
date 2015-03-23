# == Schema Information
#
# Table name: organizations
#
#  id   :integer          not null, primary key
#  name :string
#

require 'rails_helper'

RSpec.describe Organization, type: :model do


  describe "DB" do
    expect_it { to have_db_column(:name).of_type(:string) }
  end

  describe "Associations" do
    expect_it { to have_many(:roles).dependent(:destroy) }
    expect_it { to have_many(:employees).through(:roles).source(:actable).conditions(source_type: 'Employee') }
    expect_it { to have_many(:employees).through(:roles).source(:actable).conditions(source_type: 'Admin') }
    expect_it { to have_many(:projects).dependent(:destroy) }
    expect_it { to have_many(:project_assignments).through(:projects) }
    expect_it { to have_many(:weekly_project_assignments).through(:project_assignments) }
  end

  describe "Validations" do
    expect_it { to validate_presence_of(:name) }
  end

  describe "#can_user_access?" do
    expect_it { to respond_to(:can_user_access?) }
  end
end
