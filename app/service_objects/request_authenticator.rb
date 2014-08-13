class RequestAuthenticator
  def self.authenticate(user_token_header)
    if user_token_header.present?
      # Parse http header
      combined_token = user_token_header.split(":")
      user_id = combined_token[0]
      authentication_token = combined_token[1]

      # Check for user
      user = user_id && User.find_by(id: user_id)

      # Compare id:token combination to mitigate timing attacks
      if user && Devise.secure_compare(
        user.obfuscated_authentication_token, 
        "#{user_id}:#{authentication_token}"
      )
        user
      else
        false
      end
    else
      false
    end
  end
end
