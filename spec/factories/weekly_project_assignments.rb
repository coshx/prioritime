# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :weekly_project_assignment do
    association :project_assignment
    week_start 2.weeks.from_now.at_beginning_of_week.to_date
    days_working 3
  end
end
