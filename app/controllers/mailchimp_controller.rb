class MailchimpController < ApplicationController
  def send_test_email
    email = 'test@example.com'

    if MailchimpService.send_test_email(email)
      flash[:success] = 'Test email sent successfully via Mailchimp!'
    else
      flash[:error] = 'Failed to send test email via Mailchimp.'
    end
  end
end
