# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'json'

cocktails_number = 10
ingredients_max_rand_number = 4

cocktaildb_url = "https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"
ingredients = JSON.parse(open(cocktaildb_url).read)['drinks']
ingredients = ingredients.map { |x| x.values }.flatten

def main_separator
  puts "\n\n" + "*" * 50 + "\n\n"
end

def alt_separator
  puts "-" * 50 + "\n\n"
end


puts "Seeding started."

main_separator

puts "Adding Ingredients..."
alt_separator
ingredients.each do |ing|
  Ingredient.create(name: ing)
  puts "-- Added #{ing}."
end
alt_separator
puts "Done"

main_separator

puts "Cleaning database..."
alt_separator
puts "-- Cleaning Cocktails..."
# Cocktail.destroy_all
# alt_separator
# puts "-- Cleaning Ingredients..."
# Ingredient.destroy_all
puts "Database is now clean."

main_separator

puts "Creating cocktails..."
# cocktails_number.times do
# end

puts "Finished!"