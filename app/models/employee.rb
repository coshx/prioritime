class Employee < ActiveRecord::Base
  acts_as :role

  has_many :project_assignments, dependent: :destroy
  has_many :projects, through: :project_assignments
  has_many :weekly_project_assignments, through: :project_assignments, dependent: :destroy

  validates :name, :title, :hour_capacity, presence: true
end