class EmbeddedProjectAssignmentSerializer < ActiveModel::Serializer
  attributes :id, :summary
  has_one :project, serializer: ProjectShortSerializer
  has_many :weekly_project_assignments
end