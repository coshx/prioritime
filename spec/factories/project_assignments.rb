# == Schema Information
#
# Table name: project_assignments
#
#  id          :integer          not null, primary key
#  employee_id :integer
#  project_id  :integer
#  summary     :string           default("")
#  created_at  :datetime
#  updated_at  :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project_assignment do
    association :person
    project { FactoryGirl.create :project, user: person.user }
    summary "MyString"
  end
end
