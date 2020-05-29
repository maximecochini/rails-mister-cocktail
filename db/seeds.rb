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
ratings_max_rand_number = 15

# cocktaildb_url = "https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"
# ingredients = JSON.parse(open(cocktaildb_url).read)['drinks']
# ingredients = ingredients.map { |x| x.values }.flatten

ingredients = Ingredient.all

cocktails = [
  {name: 'Old Fashioned', photo: 'https://www.thecocktaildb.com/images/media/drink/vrwquq1478252802.jpg', cover: 'https://253qv1sx4ey389p9wtpp9sj0-wpengine.netdna-ssl.com/wp-content/uploads/2019/09/COM_photocredit_Jens_Johnson_1920x1280.jpg'},
  {name: 'Long Island Tea', photo: 'https://www.thecocktaildb.com/images/media/drink/tppn6i1589574695.jpg', cover: 'https://img.ohmymag.com/article/recette/le-long-island_dfd4b477b33486129ed63b692e2b9862628e6b59.jpg'},
  {name: 'Negroni', photo: 'https://www.thecocktaildb.com/images/media/drink/qgdu971561574065.jpg', cover: 'https://static1.villaschweppes.com/articles/1/48/82/1/@/350756-le-cocktail-negroni-opengraph_1200-2.jpeg'},
  {name: 'Whiskey Sour', photo: 'https://www.thecocktaildb.com/images/media/drink/hbkfsh1589574990.jpg', cover: 'https://assets.punchdrink.com/wp-content/uploads/2017/10/Social-Whiskey-Sour-3.jpg'},
  {name: 'Dry Martini', photo: 'https://www.thecocktaildb.com/images/media/drink/6ck9yi1589574317.jpg', cover: 'https://assets.afcdn.com/recipe/20180827/81970_w648h344c1cx518cy627cxt0cyt0cxb2118cyb1412.jpg'},
  {name: 'Margarita', photo: 'https://www.thecocktaildb.com/images/media/drink/5noda61589575158.jpg', cover: 'https://assets.afcdn.com/recipe/20180705/80288_w648h344c1cx1473cy1313cxt0cyt0cxb4493cyb3286.jpg'},
  {name: 'Moscow Mule', photo: 'https://www.thecocktaildb.com/images/media/drink/3pylqc1504370988.jpg', cover: 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRMoLNnp392506A5b_6P7f_KBCu39fRx4qgDv6_YRVB9GA504lT&usqp=CAU'},
  {name: 'Mojito', photo: 'https://www.thecocktaildb.com/images/media/drink/3z6xdi1589574603.jpg', cover: 'https://assets.afcdn.com/recipe/20180801/81659_w648h344c1cx2774cy1849cxt0cyt0cxb5541cyb3691.jpg'}
]

# base_url = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s="
# cocktails.each do |cocktail|
# cocktail_hash = JSON.parse(open(base_url).read)['drinks']
# end


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
  puts "Creating #{cocktail[:name]}..."
  cocktail_instance = Cocktail.new(name: cocktail[:name])
  cocktail_instance.photo.attach(io: URI.open(cocktail[:photo]), filename: "#{cocktail[:name].gsub(" ","_")}_photo.jpg", content_type: "image/jpg")
  cocktail_instance.cover.attach(io: URI.open(cocktail[:cover]), filename: "#{cocktail[:name].gsub(" ","_")}_cover.jpg", content_type: "image/jpg")
  cocktail_instance.save

  num = rand(1..ingredients_max_rand_number)
  temp_i = ingredients.sample(num)
  puts "-- Ingredients: #{temp_i.join(", ")}.\n\n"
  puts "Creating #{cocktail_instance.name} recipe with #{num} ingredients..."
  temp_i.each do |ingredient|
    charge = rand(1..10)
    description = "#{charge}cl"
    dose = Dose.new
    dose.description = description
    dose.ingredient = ingredient
    dose.cocktail = cocktail_instance
    puts "-- [#{dose.cocktail.name}]: #{dose.description} of #{dose.ingredient.name}."
    dose.save
  end
  puts "\nCreated #{cocktail_instance.name} recipe."

  alt_separator
  
  ratingsnum = rand(1..ratings_max_rand_number)

  puts "Populating #{cocktail} with #{ratingsnum} reviews.\n\n"
  ratingsnum.times do
    faker_review = {
      rating: rand(0..5),
      content: Faker::Hipster.sentence
    }
    review = Review.new(faker_review)
    review.cocktail = cocktail_instance
    review.save
    puts "----- #{review.content}.\n\n"
  end
end

puts "END OF SEED - No errors."