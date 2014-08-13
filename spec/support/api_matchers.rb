# API Matcher config
APIMatchers.setup do |config|
  config.http_status_method = :status
  config.response_body_method = :body
  config.header_method = :headers
  config.header_content_type_key = 'Content-Type'
end
