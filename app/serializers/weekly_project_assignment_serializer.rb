class WeeklyProjectAssignmentSerializer < ActiveModel::Serializer
  attributes :id, :start_date, :days_working

  def start_date
    object.week_start.strftime("%m/%d")
  end
end
