class NewWeeklyProjectAssignmentSerializer < ActiveModel::Serializer
  # NOTE not sure why I need :project_assignment_id here in order
  # for WeeklyProjectAssignment to belongTo ProjectAssignment in ember
  root :weekly_project_assignment
  attributes :id, :project_assignment_id, :week_start, :days_working
  has_one :project_assignment
end
