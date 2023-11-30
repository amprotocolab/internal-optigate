require 'securerandom'

class OtpService
  def initialize(phone_number)
    @phone_number = phone_number
    @twilio_account_sid = ENV['TWILIO_ACCOUNT_SID']
    @twilio_auth_token = ENV['TWILIO_AUTH_TOKEN']
    @twilio_phone_number = ENV['TWILIO_PHONE_NUMBER']
  end

  def send_otp
    otp_code = generate_otp_code
    send_otp_via_twilio(otp_code)
    otp_code
  end

  def verify_otp?(otp_code, user_input)
    otp_code == user_input
  end

  private

  def generate_otp_code
    SecureRandom.random_number(1_000_000).to_s.rjust(6, '0')
  end

  def send_otp_via_twilio(otp_code)
    begin
      client = Twilio::REST::Client.new(@twilio_account_sid, @twilio_auth_token)

      message = client.messages.create(
        body: "Your OTP is: #{otp_code}",
        to: @phone_number,
        from: @twilio_phone_number
      )

      Rails.logger.info("OTP message SID: #{message.sid}")    rescue Twilio::REST::TwilioError => e
      raise OtpSendingError, "Error sending OTP via Twilio: #{e.message}"    end
  end
end
