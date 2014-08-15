class PersonSerializer < ActiveModel::Serializer
  attributes :id, :name, :title, :description, :hour_capacity
  has_many :project_assignments, serializer: EmbeddedProjectAssignmentSerializer
end
