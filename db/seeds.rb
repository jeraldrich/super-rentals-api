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

# Create rentals.
20.times do
  rental = Rental.create!(
    owner: api_user,
    title: Faker::Address.full_address,
    city: Faker::Address.city,
    location: Faker::Address.street_address,
    street_address: Faker::Address.street_address,
    category: Faker::House.room,
    image: Faker::File.file_name(dir: 'spec/images', name: 'test_rental_image', ext: 'jpg'),
    bedrooms: Faker::Number.number(digits: 1),
    description: Faker::House.room
  )
end