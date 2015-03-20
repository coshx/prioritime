# == Schema Information
#
# Table name: organizations
#
#  id   :integer          not null, primary key
#  name :string
#

FactoryGirl.define do
  factory :organization do
    name "Great organization"
  end
end
