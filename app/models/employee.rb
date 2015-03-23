class Employee < ActiveRecord::Base
  acts_as :role

  has_many :project_assignments, dependent: :destroy
  has_many :projects, through: :project_assignments
  has_many :weekly_project_assignments, through: :project_assignments, dependent: :destroy

  validates :name, :title, :hour_capacity, :organization_id, presence: true

  def send_invitation_to(email)
    # pending for now
    puts 'send invitation'
  end
end