class Project < ActiveRecord::Base
  belongs_to :organization

  has_many :project_assignments, dependent: :destroy
  has_many :weekly_project_assignments, through: :project_assignments

  validates :name, :client, :organization_id, presence: true
end
