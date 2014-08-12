FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user_#{n}@email.com" }
    sequence(:password) { |n| "super_secret_#{n}"}
  end

  factory :person do
    association :user

    name "Bob Hope"
    title "Chief Taco Consumer"
    description "Bob is a well renowned connisseur of all things taco, including breakfast tacos and dinner tacos. He also writes Rails in his spare time."
    hour_capacity 40
  end
end
