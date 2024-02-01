FactoryBot.define do
  factory :form do
    form_type { 1 }
    title { "MyString" }
    custom_css { "MyText" }
    html_script { "" }
    state { 1 }
  end
end
