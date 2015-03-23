# == Schema Information
#
# Table name: project_assignments
#
#  id          :integer          not null, primary key
#  employee_id :integer
#  project_id  :integer
#  summary     :string           default("")
#  start_date  :datetime
#  end_date    :datetime
#

require 'rails_helper'

RSpec.describe ProjectAssignment, type: :model do
  describe "Associations" do
    expect_it { to belong_to(:employee) }
    expect_it { to belong_to(:project) }
  end

  describe "Validations" do
    expect_it { to validate_presence_of(:project_id) }
    expect_it { to validate_presence_of(:employee_id) }
    expect_it { to validate_presence_of(:start_date) }
    expect_it { to validate_presence_of(:end_date) }
  end
end
