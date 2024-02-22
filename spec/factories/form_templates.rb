FactoryBot.define do
  factory :form_template do
    form_type { 1 }
    title { "MyString" }
    custom_css { "MyText" }
    html_script { "" }
    state { 1 }
    prebuilt { false }
  end
end
