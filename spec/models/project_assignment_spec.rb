# == Schema Information
#
# Table name: project_assignments
#
#  id          :integer          not null, primary key
#  employee_id :integer
#  project_id  :integer
#  summary     :string           default("")
#  created_at  :datetime
#  updated_at  :datetime
#

require 'rails_helper'

RSpec.describe ProjectAssignment, type: :model do
  describe "Associations" do
    expect_it { to belong_to(:employee) }
    expect_it { to belong_to(:project) }
    expect_it { to have_many(:weekly_project_assignments).dependent(:destroy) }
  end

  describe "Validations" do
    expect_it { to validate_presence_of(:project_id) }
    expect_it { to validate_presence_of(:employee_id) }
    expect_it { to validate_uniqueness_of(:employee_id).scoped_to(:project_id).with_message("can't assign the same person to the same project multiple times") }
  end
end
