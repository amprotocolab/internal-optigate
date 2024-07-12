# spec/models/form_field_spec.rb
require 'rails_helper'

RSpec.describe FormField, type: :model do
  let(:form) { create(:form) }
  let(:form_field) { create(:form_field, form: form) }

  it "is valid with valid attributes" do
    expect(form_field).to be_valid
  end

  it "is not valid without a uuid" do
    form_field.uuid = nil
    expect(form_field).to_not be_valid
  end

  it "is not valid without a field_type" do
    form_field.field_type = nil
    expect(form_field).to_not be_valid
  end

  it "is not valid without custom_css" do
    form_field.custom_css = nil
    expect(form_field).to_not be_valid
  end

  it "is not valid without a label" do
    form_field.label = nil
    expect(form_field).to_not be_valid
  end

  it "is not valid without a font_type" do
    form_field.font_type = nil
    expect(form_field).to_not be_valid
  end

  it "is not valid without a font_size" do
    form_field.font_size = nil
    expect(form_field).to_not be_valid
  end

  it "is not valid without a font_family" do
    form_field.font_family = nil
    expect(form_field).to_not be_valid
  end

  it "is not valid without a fill_color" do
    form_field.fill_color = nil
    expect(form_field).to_not be_valid
  end

  it "is not valid without a fill_color_percent" do
    form_field.fill_color_percent = nil
    expect(form_field).to_not be_valid
  end

  it "is not valid without an alignment_type" do
    form_field.alignment_type = nil
    expect(form_field).to_not be_valid
  end

  it "belongs to a form" do
    expect(form_field.form).to eq(form)
  end
end
