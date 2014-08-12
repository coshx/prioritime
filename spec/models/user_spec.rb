require 'rails_helper'

RSpec.describe User, :type => :model do
  describe "associations" do
    subject { create :user }
    let!(:person1) { create :person, user: subject }
    let!(:person2) { create :person, user: subject }

    it "has many people" do
      expect(subject.people.count).to eq(2)
    end

    it "destroys people when it deleted (how violent!)" do
      expect {
        subject.destroy!
      }.to change{Person.count}.by(-2)

      expect(Person.where(id: person1.id)).to be_empty
    end
  end
end
