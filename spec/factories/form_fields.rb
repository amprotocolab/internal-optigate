FactoryBot.define do
  factory :form_field do
    uuid { "MyString" }
    field_type { 1 }
    custom_css { "MyText" }
    label { "MyText" }
    font_type { "MyString" }
    font_size { 1 }
    font_family { "MyString" }
    fill_color { "MyString" }
    fill_color_percent { 1 }
    alignment_type { 1 }
  end
end
