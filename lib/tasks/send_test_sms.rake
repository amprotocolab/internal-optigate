namespace :twilio do
  desc 'Send a test SMS using Twilio'
  task send_test_sms: :environment do
    require 'twilio-ruby'

    account_sid = Rails.application.config.twilio_account_sid
    auth_token = Rails.application.config.twilio_auth_token
    twilio_phone_number = Rails.application.config.twilio_phone_number
    to_phone_number = '+923352283667' # Replace with a valid phone number

    client = Twilio::REST::Client.new(account_sid, auth_token)

    message = client.messages.create(
      body: 'This is a test message from Twilio!',
      to: to_phone_number,
      from: twilio_phone_number
    )

    puts "Test SMS sent! SID: #{message.sid}"
  end
end
