require 'rails_helper'

RSpec.describe Person, :type => :model do
  describe "attributes" do
    it "requires a name" do
      p = Person.new
      expect(p.valid?).to eq(false)
      expect(p.errors).to include(:name)
    end

    it "requires a user_id" do
      p = Person.new
      expect(p.valid?).to eq(false)
      expect(p.errors).to include(:user_id)
    end
  end
end
