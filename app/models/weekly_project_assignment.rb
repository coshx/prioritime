# == Schema Information
#
# Table name: weekly_project_assignments
#
#  id                    :integer          not null, primary key
#  project_assignment_id :integer
#  week_start            :date
#  days_working          :integer
#  created_at            :datetime
#  updated_at            :datetime
#

class WeeklyProjectAssignment < ActiveRecord::Base
  belongs_to :project_assignment

  validates :project_assignment_id, :week_start, :days_working, presence: true
  validates :week_start, uniqueness: { scope: :project_assignment_id, message: "can't have multiple weekly assignments for the same person on one project for the same week" }

  before_create do
    ensure_week_start_is_start_of_week
  end

  def self.for_user(user)
    joins(:project_assignment => :project).where(projects: {user_id: user.id})
  end

  def self.for_person(person)
    joins(:project_assignment => :person).where(person: {id: person.id})
  end

  def self.for_project(project)
    joins(:project_assignment => :project).where(projects: {id: project.id})
  end

  # note: breaks with 12/29/2014
  def ensure_week_start_is_start_of_week
    start = self.week_start
    expected_start_of_week = Date.commercial(start.year, start.cweek, 1) # 1 => start day of the week, 7 => end day of week
    unless expected_start_of_week == self.week_start
      self.week_start = expected_start_of_week
    end
  end
end
