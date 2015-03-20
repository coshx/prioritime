# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    name "Great Project"
    description "Fun to work on and will pay really well"
    duration_weeks 5
    start_date 1.week.from_now
    client "Elon Musk"
    organization
  end
end
