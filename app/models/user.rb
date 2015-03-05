class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :async, :database_authenticatable, :registerable,
         :recoverable, :rememberable

  has_many :roles, dependent: :destroy

  before_create :set_authentication_token

  def obfuscated_authentication_token
    "#{id.to_s}:#{authentication_token}"
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
