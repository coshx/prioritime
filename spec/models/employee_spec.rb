# == Schema Information
#
# Table name: employees
#
#  id            :integer          not null, primary key
#  name          :string
#  title         :string           default("")
#  hour_capacity :integer          default("0")
#  created_at    :datetime
#  updated_at    :datetime
#

require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe "DB" do
    expect_it { to have_timestamps }
  end

  describe "Associations" do
    expect_it { to act_as_role }
    expect_it { to have_many(:project_assignments).dependent(:destroy) }
    expect_it { to have_many(:projects).through(:project_assignments) }
    expect_it { to have_many(:weekly_project_assignments).through(:project_assignments) }
  end

  describe "Validations" do
    expect_it { to validate_presence_of(:hour_capacity) }
    expect_it { to validate_presence_of(:name) }
    expect_it { to validate_presence_of(:title) }
  end
end
