# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "--- clearing database ---"
Project.destroy_all

puts "--- creating projects ---"
Project.create(name: "Ukraine")
Project.create(name: "Sierra Leone")
Project.create(name: "Northern Iraq")
