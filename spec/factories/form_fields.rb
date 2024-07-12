# spec/factories/form_fields.rb
FactoryBot.define do
  factory :form_field do
    uuid { SecureRandom.uuid }
    field_type { 0 }  # Corresponds to 'button'
    custom_css { "{}" }
    label { "Sample Label" }
    font_type { "Arial" }
    font_size { 12 }
    font_family { "Arial" }
    fill_color { "#ffffff" }
    fill_color_percent { 100 }
    alignment_type { 1 }  # Corresponds to 'center'
    association :form
  end
end
