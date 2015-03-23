class EmployeeSerializer < ActiveModel::Serializer
  attributes :id, :name, :title, :hour_capacity
end