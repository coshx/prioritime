class PersonSerializer < ActiveModel::Serializer
  attributes :id, :name, :title, :description, :hour_capacity
  has_one :user
end
