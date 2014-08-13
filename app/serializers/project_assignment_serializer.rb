class ProjectAssignmentSerializer < ActiveModel::Serializer
  attributes :id, :summary
  has_one :project
  has_many :weekly_project_assignments
end