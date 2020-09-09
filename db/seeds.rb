# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Starting Seed"
HelpOption.create(descriptionvol: "Test", descriptioncall: "Test")
HelpOption.create(descriptionvol: "Test2", descriptioncall: "Test2")
City.create(name: "Eilat")
City.create(name: "Tel Aviv")
User.create(name: "Matan", lastname: "Nahmani", email: "matanleague@gmail.com", password: "123456", phone: 0542124011, address: "Kliel ha horesh 26", israelid: 211890652, adminlevel: 4, city_id: City.first.id, student: true, gender: true, healthcheck: true)
puts "Seeding Ended"
