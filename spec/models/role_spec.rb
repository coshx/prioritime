require 'rails_helper'

RSpec.describe Role, type: :model do
  describe "DB" do
    expect_it { to have_db_index(:organization_id) }
    expect_it { to have_db_index(:user_id) }
  end

  describe "Associations" do
    expect_it { to act_as_superclass }
    expect_it { to belong_to(:user) }
    expect_it { to belong_to(:organization) }
  end

  describe "Validations" do
    expect_it { to validate_presence_of(:user_id) }
    expect_it { to validate_presence_of(:organization_id) }
  end
end