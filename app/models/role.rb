class Role < ActiveRecord::Base
  actable
  
  belongs_to :user
  belongs_to :organization
end