class WeeklyProjectAssignmentSerializer < ActiveModel::Serializer
  attributes :id, :week_start, :days_working

  def week_start_date
    object.week_start.strftime("%m/%d")
  end
end
