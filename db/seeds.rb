# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

owen = User.where(email: "owen@coshx.com").first_or_create!(
  password: "password", password_confirmation: "password"
)

%w{Ben Chielo Dave Gil Josh Michael Sang}.each do |name|
  Person.where(name: name).first_or_create!(
    title: name == "Gil" ? "Designer" : "Developer", hour_capacity: 40, user_id: owen.id
  )
end

["Couchsurfing", "Search Lateral", "ACAC", "Orbit Works", "Minr"].each do |name|
  Project.where(name: name).first_or_create!(
    client: name, user_id: owen.id
  )
end
