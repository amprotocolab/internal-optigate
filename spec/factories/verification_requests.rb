FactoryBot.define do
  factory :verification_request do
    verified { false }
    otp_code { "MyString" }
    subscriber { nil }
    form { nil }
  end
end
