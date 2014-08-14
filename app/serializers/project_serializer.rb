class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :duration_weeks, :start_date, :client, :created_at, :updated_at
  has_many :project_assignments, serializer: ProjectAssignmentShortSerializer
end
