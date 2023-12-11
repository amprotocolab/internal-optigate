class MailchimpService
  def self.send_test_email(email)
    gibbon = Gibbon::Request.new
    list_id = 'b9850c6d5e'

    begin
      response = gibbon.lists(list_id).members.create(
        body: {
          email_address: email,
          status: 'subscribed'
        }
      )

      if response.status_code == 200
        return true
      else
        Rails.logger.error("Mailchimp API Error: #{response.body}")
        return false
      end
    rescue Gibbon::MailChimpError => e
      Rails.logger.error("Mailchimp API Error: #{e.message}")
      return false
    end
  end
end
