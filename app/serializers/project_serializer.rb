class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :duration_weeks, :start_date, :client
  has_one :user
end
