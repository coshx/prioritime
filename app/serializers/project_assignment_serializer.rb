class ProjectAssignmentSerializer < ActiveModel::Serializer
  attributes :id, :summary
  has_one :project, serializer: ProjectShortSerializer
end