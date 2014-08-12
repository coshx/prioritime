require 'rails_helper'

RSpec.describe ProjectAssignment, :type => :model do
  describe "validations" do
    let(:user) { create :user }
    let(:project) { create :project, user: user }
    let(:person1) { create :person, user: user }
    let(:person2) { create :person, user: user }

    it "does not allow the same person to be assigned to the same project more than once" do
      pa1 = create :project_assignment, project: project, person: person1
      expect(pa1).to be_valid

      pa2 = build :project_assignment, project: project, person: person1
      expect(pa2).to_not be_valid
      expect(pa2.errors).to include(:person_id)
    end

    it "will allow you to have multiple people on one project" do
      pa1 = create :project_assignment, project: project, person: person1
      pa2 = create :project_assignment, project: project, person: person2
      expect(pa1).to be_valid
      expect(pa2).to be_valid
    end

    it "will allow one person to be on multiple projects" do
      project2 = create :project, user: user
      pa1 = create :project_assignment, project: project, person: person1
      pa2 = create :project_assignment, project: project2, person: person1
      expect(pa1).to be_valid
      expect(pa2).to be_valid
    end
  end
end
