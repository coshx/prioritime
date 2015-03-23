require 'rails_helper'

RSpec.describe 'EmployeeSerializer', type: :serializer do
  let(:employee) { build(:employee) }
  let(:serializer) { EmployeeSerializer.new(employee) }
  let(:subject) { serializer.attributes }

  expect_it { to have_key(:id) }
  expect_it { to have_key(:name) }
  expect_it { to have_key(:title) }
  expect_it { to have_key(:hour_capacity) }
end