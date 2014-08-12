class ProjectAssignmentSerializer < ActiveModel::Serializer
  attributes :id, :summary
  has_one :person
  has_one :project
end
