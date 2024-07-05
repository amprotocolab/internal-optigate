require 'rails_helper'

RSpec.describe Form, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      form = build(:form)
      expect(form).to be_valid
    end

    it 'is invalid without a uuid' do
      form = build(:form, uuid: nil)
      expect(form).to_not be_valid
      expect(form.errors[:uuid]).to include("can't be blank")
    end

    it 'is invalid without a form_type' do
      form = build(:form, form_type: nil)
      expect(form).to_not be_valid
      expect(form.errors[:form_type]).to include("can't be blank")
    end

    it 'is invalid without a title' do
      form = build(:form, title: nil)
      expect(form).to_not be_valid
      expect(form.errors[:title]).to include("can't be blank")
    end

    it 'is invalid without a state' do
      form = build(:form, state: nil)
      expect(form).to_not be_valid
      expect(form.errors[:state]).to include("can't be blank")
    end

    it 'is invalid without a user' do
      form = build(:form, user: nil)
      expect(form).to_not be_valid
      expect(form.errors[:user]).to include("must exist")
    end
  end
end
