# spec/factories/forms.rb
FactoryBot.define do
  factory :form do
    uuid { SecureRandom.uuid }
    form_type { 0 }  # Corresponds to 'modal'
    title { "Sample Form Title" }
    html_script { "<p>Sample HTML script</p>" }
    state { "unpublished" }
    email_confirmation_with_otp { false }
    thank_you_message { false }
    association :user

    trait :with_fields do
      after(:create) do |form|
        create_list(:form_field, 2, form: form)
      end
    end
  end
end
