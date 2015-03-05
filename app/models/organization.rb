class Organization < ActiveRecord::Base
  has_many :roles, dependent: :destroy
  has_many :employees, -> { where(as_role_type: 'Employee') }, class_name: 'Role'
  has_many :admins, -> { where(as_role_type: 'Admin') }, class_name: 'Role'
  has_many :projects, dependent: :destroy
  has_many :project_assignments, through: :projects
  has_many :weekly_project_assignments, through: :project_assignments

  validates :name, presence: true
end