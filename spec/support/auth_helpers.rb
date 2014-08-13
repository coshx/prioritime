module AuthHelpers
  def sign_in(user)
    request.headers['X-User-Token'] = user.obfuscated_authentication_token
  end
end

RSpec.configure do |config|
  config.include AuthHelpers, type: :controller
end
