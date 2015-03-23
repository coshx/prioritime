# == Schema Information
#
# Table name: organizations
#
#  id   :integer          not null, primary key
#  name :string
#

class Organization < ActiveRecord::Base
  has_many :roles, dependent: :destroy
  has_many :employees, through: :roles, source: :actable, source_type: 'Employee'
  has_many :admins, through: :roles, source: :actable, source_type: 'Admin'
  
  has_many :projects, dependent: :destroy
  has_many :project_assignments, through: :projects
  has_many :weekly_project_assignments, through: :project_assignments

  validates :name, presence: true
end
