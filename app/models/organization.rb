class Organization < ActiveRecord::Base
  has_many :roles, dependent: :destroy
  # has_many :employees, -> { where(actable_type: 'Employee') }, class_name: 'Role'
  has_many :employees, through: :roles, source: :actable, source_type: 'Employee'
  has_many :admins, through: :roles, source: :actable, source_type: 'Admin'
  
  # has_many :admins, -> { where(actable_type: 'Admin') }, class_name: 'Role'
  has_many :projects, dependent: :destroy
  has_many :project_assignments, through: :projects
  has_many :weekly_project_assignments, through: :project_assignments

  validates :name, presence: true

  def can_user_access?(user)
    admins.pluck(:user_id).include?(user.id)
  end
end
