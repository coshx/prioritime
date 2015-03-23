# == Schema Information
#
# Table name: projects
#
#  id              :integer          not null, primary key
#  name            :string
#  description     :text             default("")
#  duration_weeks  :integer          default("0")
#  start_date      :datetime
#  client          :string           default("")
#  organization_id :integer
#  created_at      :datetime
#  updated_at      :datetime
#

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
