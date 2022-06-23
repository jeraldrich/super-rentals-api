# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create api user.
unless User.exists?(email: 'apiuser@superrentals.com')
  password = Devise.friendly_token.first(8)
  api_user = User.new(
    first_name: 'Bart',
    last_name: 'Simpson',
    email: 'apiuser@superrentals.com',
    password: password,
    password_confirmation: password
  )
  api_user.skip_confirmation!
  api_user.save!
end
api_user = User.find_by(email: 'apiuser@superrentals.com') if api_user.nil?

# Since sqlite does not use enum, just pick random el in choices.
# Choices picked from example rentals json public/api/rentals.json in ember codebase.
categories = ['Estate', 'Condo', 'Apartment'] # Townhouse def in choices, but no image.
# Map category to example category image.
category_images = {
  'Estate': 'https://upload.wikimedia.org/wikipedia/commons/c/cb/Crane_estate_(5).jpg',
  'Condo': 'https://upload.wikimedia.org/wikipedia/commons/2/20/Seattle_-_Barnes_and_Bell_Buildings.jpg',
  'Apartment': 'https://upload.wikimedia.org/wikipedia/commons/f/f7/Wheeldon_Apartment_Building_-_Portland_Oregon.jpg'
}
start_lat = 47.6062
start_lng = -122.3321

# Create rentals.
20.times do
  # TODO: Use fake lat lng gem to avoid invalid lat lng error from mapbox.
  # lat = rand(start_lat...start_lat + 0.1000)
  # lng = rand(start_lng...start_lng - 0.1000)
  category = categories.sample
  category_image = category_images[category.to_sym]

  rental = Rental.create!(
    owner: api_user,
    title: Faker::Address.full_address,
    city: Faker::Address.city,
    lat: start_lat,
    lng: start_lng,
    street_address: Faker::Address.street_address,
    category: category,
    image: category_image,
    bedrooms: Faker::Number.number(digits: 1) + 1, # Add one to avoid 0 bedrooms.
    description: Faker::House.room # TODO: Use diff faker, lorem maybe if used in frontend.
  )
end
