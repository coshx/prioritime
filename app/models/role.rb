# == Schema Information
#
# Table name: roles
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  organization_id :integer
#  actable_id      :integer
#  actable_type    :string
#

class Role < ActiveRecord::Base
  actable

  belongs_to :user
  belongs_to :organization
end
