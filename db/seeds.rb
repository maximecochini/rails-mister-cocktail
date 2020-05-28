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
ingredients_max_rand_number = 6

# cocktaildb_url = "https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"
# ingredients = JSON.parse(open(cocktaildb_url).read)['drinks']
# ingredients = ingredients.map { |x| x.values }.flatten

ingredients = Ingredient.all
cocktails = ['Lemon Drop', 'Cuba Libre', 'Margarita', 'Gin Tonic', "Mint Julep", "Whiskey Sour", "Mojito"]

def main_separator
  puts "\n\n" + "*" * 50 + "\n\n"
end

def alt_separator
  puts "\n" + "-" * 50 + "\n\n"
end


puts "Seeding started."

main_separator

# puts "Adding Ingredients..."
# alt_separator
# ingredients.each do |ing|
#   Ingredient.create(name: ing)
#   puts "-- Added #{ing}."
# end
# alt_separator
# puts "Done"

# main_separator

puts "Cleaning database..."
puts "-- Cleaning Cocktails..."
Cocktail.destroy_all
puts "--- Done."
# alt_separator
# puts "-- Cleaning Ingredients..."
# Ingredient.destroy_all
# puts "--- Done."
puts "\nDatabase is now clean."

main_separator

puts "Creating #{cocktails.count} cocktails..."
puts alt_separator
# cocktails_number.times do
cocktails.each do |cocktail|
  puts "Creating #{cocktail}..."
  temp_c = Cocktail.new(name: cocktail)
  temp_c.save
  num = rand(1..ingredients_max_rand_number)
  temp_i = ingredients.sample(num)
  puts "-- Ingredients: #{temp_i.join(", ")}.\n\n"
  puts "Creating #{temp_c.name} recipe with #{num} ingredients..."
  temp_i.each do |ingredient|
    charge = rand(1..10)
    description = "#{charge}cl"
    dose = Dose.new
    dose.description = description
    dose.ingredient = ingredient
    dose.cocktail = temp_c
    puts "-- [#{dose.cocktail.name}]: #{dose.description} of #{dose.ingredient.name}."
    dose.save
  end
  puts "\nCreated #{temp_c.name} recipe."
  alt_separator
end

puts "END OF SEED - No errors."