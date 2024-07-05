require 'rails_helper'

RSpec.describe FormField, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      form_field = build(:form_field)
      expect(form_field).to be_valid
    end

    it 'is invalid without a uuid' do
      form_field = build(:form_field, uuid: nil)
      expect(form_field).to_not be_valid
      expect(form_field.errors[:uuid]).to include("can't be blank")
    end

    it 'is invalid without a field_type' do
      form_field = build(:form_field, field_type: nil)
      expect(form_field).to_not be_valid
      expect(form_field.errors[:field_type]).to include("can't be blank")
    end

    it 'is invalid without custom_css' do
      form_field = build(:form_field, custom_css: nil)
      expect(form_field).to_not be_valid
      expect(form_field.errors[:custom_css]).to include("can't be blank")
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

    it 'is invalid without a font_size' do
      form_field = build(:form_field, font_size: nil)
      expect(form_field).to_not be_valid
      expect(form_field.errors[:font_size]).to include("can't be blank")
    end

    it 'is invalid without a font_family' do
      form_field = build(:form_field, font_family: nil)
      expect(form_field).to_not be_valid
      expect(form_field.errors[:font_family]).to include("can't be blank")
    end

    it 'is invalid without a fill_color' do
      form_field = build(:form_field, fill_color: nil)
      expect(form_field).to_not be_valid
      expect(form_field.errors[:fill_color]).to include("can't be blank")
    end

    it 'is invalid without a fill_color_percent' do
      form_field = build(:form_field, fill_color_percent: nil)
      expect(form_field).to_not be_valid
      expect(form_field.errors[:fill_color_percent]).to include("can't be blank")
    end

    it 'is invalid without an alignment_type' do
      form_field = build(:form_field, alignment_type: nil)
      expect(form_field).to_not be_valid
      expect(form_field.errors[:alignment_type]).to include("can't be blank")
    end

    it 'is invalid without a user' do
      form_field = build(:form_field, user: nil)
      expect(form_field).to_not be_valid
      expect(form_field.errors[:user]).to include("must exist")
    end
  end
end
