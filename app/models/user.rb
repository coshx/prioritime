# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime
#  updated_at             :datetime
#  authentication_token   :string
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :async, :database_authenticatable, :registerable,
         :recoverable, :rememberable

  # Associations
  has_many :roles, dependent: :destroy

  # Validations
  validates :email, uniqueness: true
  
  # Callbacks
  before_create :set_authentication_token


  def obfuscated_authentication_token
    "#{id.to_s}:#{authentication_token}"
  end

  def make_admin_of_organization(organization_name)
    organization = Organization.create(name: organization_name)
    admin = Admin.create(organization: organization, user: self)
  end

  # Role-related
  def admin_of?(organization)
    self.roles.includes(:organization).where(organization_id: organization.id)
                                      .where(actable_type: 'Admin')[0].present?
  end

  def part_of?(organization)
    self.roles.includes(:organization).where(organization_id: organization.id)[0].present?
  end

  private

    def set_authentication_token
      return if authentication_token.present?
      self.authentication_token = generate(:authentication_token)
    end

    def generate(field)
      loop do
        generated_field = SecureRandom.hex
        break generated_field unless User.exists?(field => generated_field)
      end
    end
end
