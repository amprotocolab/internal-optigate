# spec/services/otp_service_spec.rb

require 'rails_helper'

RSpec.describe OtpService, type: :service do
  let(:phone_number) { '+1234567890' }

  describe '#send_otp' do
    it 'generates and sends an OTP' do
      twilio_double = instance_double(Twilio::REST::Client)
      allow(Twilio::REST::Client).to receive(:new).and_return(twilio_double)

      expect(twilio_double).to receive(:messages).and_return(messages_double = double)
      expect(messages_double).to receive(:create)

      otp_service = OtpService.new(phone_number)
      otp_code = otp_service.send_otp

      expect(otp_code).to be_present
    end
  end

  describe '#verify_otp?' do
    it 'returns true for a correct OTP' do
      otp_service = OtpService.new(phone_number)
      otp_code = otp_service.send_otp

      expect(otp_service.verify_otp?(otp_code, otp_code)).to eq(true)
    end

    it 'returns false for an incorrect OTP' do
      otp_service = OtpService.new(phone_number)
      correct_otp = otp_service.send_otp
      incorrect_otp = '123456'

      expect(otp_service.verify_otp?(correct_otp, incorrect_otp)).to eq(false)
    end
  end
end
