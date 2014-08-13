def authenticated_json_header(user)
  { 'Accept' => Mime::JSON, 
    'X-User-Token' => user.obfuscated_authentication_token }
end

def wrong_token_json_header(user)
  { 'Accept' => Mime::JSON, 
    'X-User-Token' => "wrong_token"}
end