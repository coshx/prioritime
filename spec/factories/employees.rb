# == Schema Information
#
# Table name: employees
#
#  id            :integer          not null, primary key
#  name          :string
#  title         :string           default("")
#  hour_capacity :integer          default("0")
#  created_at    :datetime
#  updated_at    :datetime
#

FactoryGirl.define do
  factory :employee do
    association :user
    sequence(:name) { |n| "Employee_#{n}" }
    title "Developer"
  end
end
