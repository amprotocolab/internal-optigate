FactoryBot.define do
  factory :form_field do
    form { nil }
    field_type { 1 }
    label { "MyText" }
    font_type { "MyString" }
    font_size { 1 }
    font_family { "MyString" }
    fill_color { "MyString" }
    fill_color_percent { "MyString" }
    alignment_type { 1 }
  end
end
