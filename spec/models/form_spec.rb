# spec/models/form_spec.rb
require 'rails_helper'

RSpec.describe Form, type: :model do
  it "is valid with valid attributes" do
    user = User.create(email: "user@example.com", password: "password")
    form = Form.new(title: "Test Form", status: "Draft", user: user)
    expect(form).to be_valid
  end

  it "is not valid without a title" do
    user = User.create(email: "user@example.com", password: "password")
    form = Form.new(status: "Draft", user: user)
    expect(form).not_to be_valid
  end

  it "is not valid without a status" do
    user = User.create(email: "user@example.com", password: "password")
    form = Form.new(title: "Test Form", user: user)
    expect(form).not_to be_valid
  end

  it "is not valid without a user" do
    form = Form.new(title: "Test Form", status: "Draft")
    expect(form).not_to be_valid
  end
end
