class ProjectAssignment < ActiveRecord::Base
  belongs_to :person
  belongs_to :project

  validates :person_id, :project_id, presence: true
  validates :person_id, uniqueness: { scope: :project_id, message: "can't assign the same person to the same project multiple times" }

  def self.for_user(user)
    joins(:project).where(projects: {user_id: user.id})
  end

  def user
    project.user
  end
end
