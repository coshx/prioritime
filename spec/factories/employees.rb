FactoryGirl.define do
  factory :employee do
    association :user
    sequence(:name) { |n| "Employee_#{n}" }
    title "Developer"
  end
end