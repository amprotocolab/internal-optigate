# spec/models/form_field_spec.rb
require 'rails_helper'

RSpec.describe FormField, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      form_field = build(:form_field)
      expect(form_field).to be_valid
    end

    it 'is invalid without a form' do
      form_field = build(:form_field, form: nil)
      expect(form_field).to_not be_valid
      expect(form_field.errors[:form]).to include("must exist")
    end

    it 'is invalid without a field_type' do
      form_field = build(:form_field, field_type: nil)
      expect(form_field).to_not be_valid
      expect(form_field.errors[:field_type]).to include("can't be blank")
    end

    it 'is invalid without a label' do
      form_field = build(:form_field, label: nil)
      expect(form_field).to_not be_valid
      expect(form_field.errors[:label]).to include("can't be blank")
    end

    it 'is invalid without a font_type' do
      form_field = build(:form_field, font_type: nil)
      expect(form_field).to_not be_valid
      expect(form_field.errors[:font_type]).to include("can't be blank")
    end

    # Add more validation tests as needed
  end

  describe 'enums' do
    it 'defines enum for field_type' do
      should define_enum_for(:field_type).with_values(button: 0, checkbox: 1)
    end

    it 'defines enum for alignment_type' do
      should define_enum_for(:alignment_type).with_values(left: 0, center: 1, right: 2)
    end
  end
end
