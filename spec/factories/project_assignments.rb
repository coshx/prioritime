# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project_assignment do
    association :person
    project { FactoryGirl.create :project, user: person.user }
    summary "MyString"
  end
end
