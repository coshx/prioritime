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

  def assign_to_organization(organization_name)
    organization = Organization.create(name: organization_name)
    admin = Admin.create(organization: organization, user: self)
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
