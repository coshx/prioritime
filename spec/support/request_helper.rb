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