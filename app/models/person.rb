class Person < ActiveRecord::Base
  belongs_to :user

  has_many :project_assignments, dependent: :destroy
  has_many :weekly_project_assignments, through: :project_assignments, dependent: :destroy

  validates :name, :user_id, presence: true
end
