# == Schema Information
#
# Table name: admins
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#

class Admin < ActiveRecord::Base
  acts_as :role
end
