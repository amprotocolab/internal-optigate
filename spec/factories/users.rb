FactoryBot.define do
  factory :user do
    sequence(:email)      { |n| "#{n}#{Faker::Internet.email}" }
    password              { 'password' }
    sequence(:first_name) { |n| "Vincent#{n}" }
    sequence(:last_name)  { |n| "Vega#{n}" }
    phone_number          { Faker::PhoneNumber.phone_number }
    confirmed_at          { Time.current }
    role_ids              { [Role.app_user.id] }

    trait :super_admin do
      role_ids { [Role.super_admin.id] }
    end

    trait :app_user do
      role_ids { [Role.app_user.id] }
    end
  end
end
