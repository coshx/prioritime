class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :people, dependent: :destroy
  has_many :projects, dependent: :destroy
  has_many :project_assignments, through: :projects
  has_many :weekly_project_assignments, through: :project_assignments
end
