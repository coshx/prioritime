class ProjectAssignmentSerializer < ActiveModel::Serializer
  attributes :id, :summary
  has_many :weekly_project_assignments
end