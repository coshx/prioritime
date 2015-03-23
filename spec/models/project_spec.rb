# == Schema Information
#
# Table name: projects
#
#  id              :integer          not null, primary key
#  name            :string
#  description     :text             default("")
#  duration_weeks  :integer          default("0")
#  start_date      :datetime
#  client          :string           default("")
#  organization_id :integer
#  created_at      :datetime
#  updated_at      :datetime
#

require 'rails_helper'

RSpec.describe Project, :type => :model do
  describe "DB" do
    expect_it { to have_db_column(:description).of_type(:text) }
    expect_it { to have_db_column(:duration_weeks).of_type(:integer) }
    expect_it { to have_db_column(:start_date).of_type(:datetime) }
    expect_it { to have_timestamps }
    expect_it { to have_db_index(:organization_id) }
  end

  describe "Associations" do
    expect_it { to belong_to(:organization) }
    expect_it { to have_many(:project_assignments).dependent(:destroy) }
    expect_it { to have_many(:weekly_project_assignments).through(:project_assignments) }
  end

  describe "Validations" do
    expect_it { to validate_presence_of(:name) }
    expect_it { to validate_presence_of(:client) }
    expect_it { to validate_presence_of(:organization_id) }
  end

  describe "#can_user_access?" do
    expect_it { to respond_to(:can_user_access?) }
  end
end
