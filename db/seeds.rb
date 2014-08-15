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

%w{Ben Chielo Dave Gabe Gil Josh Michael Sang}.each do |name|
  Person.where(name: name).first_or_create!(
    title: name == "Gil" ? "Designer" : "Developer", hour_capacity: 40, user_id: owen.id
  )
end

["Couchsurfing", "Search Lateral", "ACAC", "Orbit Works", "Minr", "TechShare", "BoozeCity"].each do |name|
  Project.where(name: name).first_or_create!(
    client: name, user_id: owen.id
  )
end

start_monday = Chronic.parse("last monday").to_date

dave = Person.find_by_name("Dave")
couchsurfing = Project.find_by_name("Couchsurfing")

dave_cs = ProjectAssignment.where(project_id: couchsurfing.id, person_id: dave.id)
  .first_or_create!(summary: "a couple days a week indefinitely")

10.times do |i|
  WeeklyProjectAssignment.where(project_assignment_id: dave_cs.id, week_start: start_monday + i.weeks)
    .first_or_create!(days_working: 5)
end

gabe = Person.find_by_name("Gabe")
search_lateral = Project.find_by_name("Search Lateral")
booze_city = Project.find_by_name("BoozeCity")
techshare = Project.find_by_name("TechShare")

gabe_sl = ProjectAssignment.where(project_id: search_lateral.id, person_id: gabe.id)
  .first_or_create!(summary: "a couple days a week indefinitely")

gabe_bc = ProjectAssignment.where(project_id: booze_city.id, person_id: gabe.id)
  .first_or_create!(summary: "a couple days a week indefinitely")

gabe_ts = ProjectAssignment.where(project_id: techshare.id, person_id: gabe.id)
  .first_or_create!(summary: "a couple days a week indefinitely")

10.times do |i|
  WeeklyProjectAssignment.where(project_assignment_id: gabe_sl.id, week_start: start_monday + i.weeks)
    .first_or_create!(days_working: 3)
  WeeklyProjectAssignment.where(project_assignment_id: gabe_bc.id, week_start: start_monday + i.weeks)
    .first_or_create!(days_working: 2)
  WeeklyProjectAssignment.where(project_assignment_id: gabe_ts.id, week_start: start_monday + i.weeks)
    .first_or_create!(days_working: 2)
end

sang = Person.find_by_name("Sang")
acac = Project.find_by_name("ACAC")

sang_acac = ProjectAssignment.where(project_id: acac.id, person_id: sang.id)
  .first_or_create!(summary: "35 hours/week for 10 weeks")

10.times do |i|
  WeeklyProjectAssignment.where(project_assignment_id: sang_acac.id, week_start: start_monday + i.weeks)
    .first_or_create!(days_working: 5)
end

start_monday = Chronic.parse("September 1").to_date
ben = Person.find_by_name("Ben")
ow = Project.find_by_name("Orbit Works")

ben_ow = ProjectAssignment.where(project_id: ow.id, person_id: ben.id)
  .first_or_create!(summary: "full time for a year")

8.times do |i|
  WeeklyProjectAssignment.where(project_assignment_id: ben_ow.id, week_start: start_monday + i.weeks)
    .first_or_create!(days_working: 5)
end
