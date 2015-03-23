# == Schema Information
#
# Table name: project_assignments
#
#  id          :integer          not null, primary key
#  employee_id :integer
#  project_id  :integer
#  summary     :string           default("")
#  start_date  :datetime
#  end_date    :datetime
#

class ProjectAssignment < ActiveRecord::Base
  belongs_to :employee
  belongs_to :project

  validates :employee_id, :project_id, :start_date, :end_date, presence: true

  def self.for_organization(organization)
    joins(:project).where(projects: { organization_id: organization.id })
  end

  def organization
    project.organization
  end
end
