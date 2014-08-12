class WeeklyProjectAssignment < ActiveRecord::Base
  belongs_to :project_assignment

  validates :project_assignment_id, :week_start, :days_working, presence: true
  validates :week_start, uniqueness: { scope: :project_assignment_id, message: "can't have multiple weekly assignments for the same person on one project for the same week" }

  def self.for_user(user)
    joins(:project_assignment => :project).where(projects: {user_id: user.id})
  end

  def self.for_person(person)
    joins(:project_assignment => :person).where(person: {id: person.id})
  end

  def self.for_project(project)
    joins(:project_assignment => :project).where(projects: {id: project.id})
  end
end
