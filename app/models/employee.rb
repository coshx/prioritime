class Employee < ActiveRecord::Base
  acts_as :role

  validates :name, :title, :hour_capacity, presence: true
end