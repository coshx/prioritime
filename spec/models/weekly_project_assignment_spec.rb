require 'rails_helper'

RSpec.describe WeeklyProjectAssignment, :type => :model do
  let(:user) { create :user }
  let(:project) { create :project, user: user }
  let(:person) { create :person, user: user }
  let(:person2) { create :person, user: user }
  let(:project_assignment) { create :project_assignment, person: person, project: project }

  describe "validations" do
    it "will not let you make more than one WeeklyProjectAssignment for a single project that has the same start date" do
      start_date = 2.weeks.from_now.to_date.at_beginning_of_week
      wpa1 = create :weekly_project_assignment, project_assignment: project_assignment, week_start: start_date
      expect(wpa1).to be_valid

      wpa2 = build :weekly_project_assignment, project_assignment: project_assignment, week_start: start_date
      expect(wpa2).to_not be_valid
      expect(wpa2.errors).to include(:week_start)
    end

    it "will let you have multiple WeeklyProjectAssignments for one person on one project if they are on different weeks" do
      start_dates = (2..4).map do |w|
        w.weeks.from_now.to_date.at_beginning_of_week
      end

      start_dates.each do |start_date|
        wpa = create :weekly_project_assignment, project_assignment: project_assignment, week_start: start_date
        expect(wpa).to be_valid
      end
    end
  end
end
