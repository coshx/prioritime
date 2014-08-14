class WeeklyProjectAssignmentSerializer < ActiveModel::Serializer
  # NOTE not sure why I need :project_assignment_id here in order
  # for WeeklyProjectAssignment to belongTo ProjectAssignment in ember
  attributes :id, :project_assignment_id, :week_start, :days_working

  def week_start_date
    object.week_start.strftime("%m/%d")
  end
end
