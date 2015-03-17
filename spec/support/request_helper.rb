def make_request(route_type, route_url, data, header)
  if route_type == :get
    get(route_url, data, header)
  elsif route_type == :post
    post(route_url, data, header)
  elsif route_type == :put
    put(route_url, data, header)
  elsif route_type == :patch
    patch(route_url, data, header)
  elsif route_type == :delete
    delete(route_url, data, header)
  end
end

def get_request(params)
  get(route[:url], params, authenticated_json_header(user))
end

def post_request(params)
  post(route[:url], params, authenticated_json_header(user))
end

def patch_request(params)
  patch(route[:url], params, authenticated_json_header(user))
end

def put_request(params)
  put(route[:url], params, authenticated_json_header(user))
end

def delete_request(params)
  delete(route[:url], params, authenticated_json_header(user))
end