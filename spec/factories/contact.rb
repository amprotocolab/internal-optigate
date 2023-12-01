FactoryBot.define do
  factory :contact do
    uuid             { SecureRandom.uuid }
    first_name      { Faker::Name.first_name }
    last_name       { Faker::Name.last_name }
    email           { Faker::Internet.email }
    contact_number  { Faker::PhoneNumber.phone_number }
    message         { Faker::Lorem.paragraph }
    
    trait :with_required_fields do
      # Add any additional customization for the factory with required fields
    end
  end
end