require 'rails_helper'

RSpec.describe Admin, type: :model do
  describe "DB" do
    expect_it { to have_timestamps }
  end

  describe "Associations" do
    expect_it { to act_as_role }
  end
end