# == Schema Information
#
# Table name: projects
#
#  id              :integer          not null, primary key
#  name            :string
#  description     :text             default("")
#  duration_weeks  :integer          default("0")
#  start_date      :datetime
#  client          :string           default("")
#  organization_id :integer
#  created_at      :datetime
#  updated_at      :datetime
#

class Project < ActiveRecord::Base
  belongs_to :organization

  has_many :project_assignments, dependent: :destroy
  has_many :weekly_project_assignments, through: :project_assignments

  validates :name, :client, :organization_id, presence: true
end
