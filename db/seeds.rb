# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'restaurants.csv'))
restaurants = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
restaurants.each do |row|
  restaurant = Restaurant.new
  restaurant.name = row["Restaurant Name"]
  restaurant.street_address = row["Street Address"]
  restaurant.postal_code = row["Post Code"]
  restaurant.number_of_chairs = row["Number of Chairs"]
  restaurant.save
end
