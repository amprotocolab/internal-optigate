# spec/models/contact_spec.rb
require 'rails_helper'

RSpec.describe Contact, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      contact = build(:contact)
      expect(contact).to be_valid
    end

    it 'is invalid without a uuid' do
      contact = build(:contact, uuid: nil)
      expect(contact).to_not be_valid
      expect(contact.errors[:uuid]).to include("can't be blank")
    end

    it 'is invalid without a first name' do
      contact = build(:contact, first_name: nil)
      expect(contact).to_not be_valid
      expect(contact.errors[:first_name]).to include("can't be blank")
    end

    it 'is invalid without a last name' do
      contact = build(:contact, last_name: nil)
      expect(contact).to_not be_valid
      expect(contact.errors[:last_name]).to include("can't be blank")
    end

    it 'is invalid without an email' do
      contact = build(:contact, email: nil)
      expect(contact).to_not be_valid
      expect(contact.errors[:email]).to include("can't be blank")
    end

    it 'is invalid without a contact number' do
      contact = build(:contact, contact_number: nil)
      expect(contact).to_not be_valid
      expect(contact.errors[:contact_number]).to include("can't be blank")
    end

    it 'is invalid without a message' do
      contact = build(:contact, message: nil)
      expect(contact).to_not be_valid
      expect(contact.errors[:message]).to include("can't be blank")
    end
  end
end
