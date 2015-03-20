FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user_#{n}@email.com" }
    sequence(:password) { |n| "super_secret_#{n}"}
  end
end
