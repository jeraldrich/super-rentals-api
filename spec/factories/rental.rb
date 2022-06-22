FactoryBot.define do
  factory :rental do
    owner { create(:user) }
    title { Faker::Address.full_address }
    city { Faker::Address.city }
    location { Faker::Address.street_address }
    street_address { Faker::Address.street_address }
    category { Faker::House.room } # TODO: Replace with enum of rental categories.
    image { Faker::File.file_name(dir: 'spec/images', name: 'test_rental_image', ext: 'jpg') }
    bedrooms { Faker::Number.number(digits: 1) }
    description { Faker::House.room }
  end
end