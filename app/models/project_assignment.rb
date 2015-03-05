class ProjectAssignment < ActiveRecord::Base
  belongs_to :employee
  belongs_to :project

  has_many :weekly_project_assignments, dependent: :destroy

  validates :employee_id, :project_id, presence: true
  validates :employee_id, uniqueness: { scope: :project_id, message: "can't assign the same person to the same project multiple times" }

  def self.for_user(user)
    joins(:project).where(projects: {user_id: user.id})
  end

  def user
    project.user
  end
end
