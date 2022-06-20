FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { "#{first_name}.#{last_name}@example.com".tr(' ', '-').downcase }
    password { 'zer0coo1' }
    confirmed_at { Time.zone.now }
    phone { Faker::PhoneNumber.phone_number }
  end
end