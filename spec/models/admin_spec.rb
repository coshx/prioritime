# == Schema Information
#
# Table name: admins
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe Admin, type: :model do
  describe "DB" do
    expect_it { to have_timestamps }
  end

  describe "Associations" do
    expect_it { to act_as_role }
  end

  describe "Validations" do
    expect_it { to validate_presence_of(:organization_id) }
    expect_it { to validate_presence_of(:user_id) }
  end
end
