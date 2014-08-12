json.array!(@people) do |person|
  json.extract! person, :id, :name, :title, :description, :hour_capacity, :user_id
  json.url person_url(person, format: :json)
end
