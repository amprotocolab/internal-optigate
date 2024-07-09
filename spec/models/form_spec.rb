# spec/models/form_spec.rb
require 'rails_helper'

RSpec.describe Form, type: :model do
  let(:user) { create(:user) }
  let(:form) { create(:form, user: user) }

  it "is valid with valid attributes" do
    expect(form).to be_valid
  end

  it "is not valid without a uuid" do
    form.uuid = nil
    expect(form).to_not be_valid
  end

  it "is not valid without a form_type" do
    form.form_type = nil
    expect(form).to_not be_valid
  end

  it "is not valid without a title" do
    form.title = nil
    expect(form).to_not be_valid
  end

  it "is not valid without a state" do
    form.state = nil
    expect(form).to_not be_valid
  end

  it "is not valid without email_confirmation_with_otp" do
    form.email_confirmation_with_otp = nil
    expect(form).to_not be_valid
  end

  it "is not valid without thank_you_message" do
    form.thank_you_message = nil
    expect(form).to_not be_valid
  end

  it "has many form_fields" do
    form_with_fields = create(:form, :with_fields, user: user)
    expect(form_with_fields.form_fields.size).to eq(2)
  end
end
