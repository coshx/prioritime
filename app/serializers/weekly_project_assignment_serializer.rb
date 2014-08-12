class WeeklyProjectAssignmentSerializer < ActiveModel::Serializer
  attributes :id, :project_assignment, :week_start, :days_working
end
