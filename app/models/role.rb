class Role < ActiveRecord::Base
  actable
  
  belongs_to :user
  belongs_to :organization

  validates :organization_id, :user_id, presence: true
end