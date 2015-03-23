# == Schema Information
#
# Table name: weekly_project_assignments
#
#  id                    :integer          not null, primary key
#  project_assignment_id :integer
#  week_start            :date
#  days_working          :integer
#  created_at            :datetime
#  updated_at            :datetime
#

require 'rails_helper'

RSpec.describe WeeklyProjectAssignment, :type => :model do
  let(:start_date) { 2.weeks.from_now.to_date.at_beginning_of_week }
  let(:organization) { create :organization }
  let(:user) { create :user }
  let(:employee) { create :employee, organization: organization }
  let(:project) { create :project }
  let(:assignment) { create :project_assignment, project: project,
                                                 employee: employee }

  describe "validations" do

    it "rejects assignements with the same project and start date" do

      wpa1 = create :weekly_project_assignment, project_assignment: assignment,
                                                week_start: start_date
      expect(wpa1).to be_valid


      wpa2 = build :weekly_project_assignment, project_assignment: assignment,
                                               week_start: start_date
      expect(wpa2).to_not be_valid
      expect(wpa2.errors).to include(:week_start)
    end

    it "will let you have multiple WeeklyProjectAssignments for one person on one project if they are on different weeks" do
      start_dates = (2..4).map do |w|
        w.weeks.from_now.to_date.at_beginning_of_week
      end

      start_dates.each do |start_date|
        wpa = create :weekly_project_assignment, project_assignment: assignment,
                                                 week_start: start_date
        expect(wpa).to be_valid
      end
    end

    it "sets the week_start to the start of the week if the day given is not actually the start of a week" do
      wednesday = Date.parse("2070/05/07") # May 7 2070 is a Wednesday, the start of the week is May 5
      wpa = create :weekly_project_assignment, project_assignment: assignment,
                                               week_start: wednesday

      expect(wpa.reload.week_start).to eq(Date.parse("2070/05/05"))
    end
  end
end
