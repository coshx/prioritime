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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :weekly_project_assignment do
    project_assignment
    week_start 2.weeks.from_now.at_beginning_of_week.to_date
    days_working 3
  end
end
