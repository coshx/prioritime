require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe "DB" do
    expect_it { to have_timestamps }
  end

  describe "Associations" do
    expect_it { to act_as_role }
  end

  describe "Validations" do
    expect_it { to validate_presence_of(:hour_capacity) }
    expect_it { to validate_presence_of(:name) }
    expect_it { to validate_presence_of(:title) }
  end
end