require 'rails_helper'

RSpec.describe VerificationRequest, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:otp_code) }
    it { should validate_presence_of(:status) }
  end

  describe 'associations' do
    it { should belong_to(:subscriber) }
    it { should belong_to(:form) }
  end

  describe 'callbacks' do
    it 'generates OTP before validation on create' do
      verification_request = build(:verification_request, otp_code: nil)
      verification_request.valid?
      expect(verification_request.otp_code).to be_present
    end
  end

  describe 'status enum' do
    it 'sets default status to "pending"' do
      verification_request = create(:verification_request, status: nil)
      expect(verification_request.status).to eq('pending')
    end

    it 'allows valid status values' do
      should define_enum_for(:status)
        .with_values(%w[pending verified expired])
    end
  end
end
