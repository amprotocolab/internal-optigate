FactoryBot.define do
  factory :system_notification do
    title { "MyString" }
    content { "MyText" }
    state { "draft" } # Set the initial state

    trait :sent do
      after(:create) { |notification| notification.send_notification! }
    end

    trait :read do
      after(:create) { |notification| notification.mark_as_read! }
    end

    trait :archived do
      after(:create) { |notification| notification.archive! }
    end
  end
end
