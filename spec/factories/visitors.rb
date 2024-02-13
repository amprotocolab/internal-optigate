# spec/factories/visitors.rb
FactoryBot.define do
  factory :visitor do
    form
    title { "MyString" }
    email { "MyString" }
    phone_number { "MyString" }
    company { "MyString" }
    otp_code { "MyString" }
    subscriber { false }
  end
end
