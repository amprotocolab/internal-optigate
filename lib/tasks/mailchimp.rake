namespace :mailchimp do
  desc 'Check Mailchimp Integration'
  task check_integration: :environment do
    begin
      gibbon = Gibbon::Request.new
      response = gibbon.lists.retrieve

      if response.status_code == 200
        lists = response.body['lists']

        if lists.present?
          lists.each do |list|
            puts "List ID: #{list['id']}"
            puts "List Name: #{list['name']}"
            puts "Member Count: #{list['stats']['member_count']}"
            puts "-----------------------"
          end
        else
          puts 'No Mailchimp lists found.'
        end
      else
        puts "Error: Unable to fetch Mailchimp lists. Response Code: #{response.status_code}"
        puts "Response Body: #{response.body.inspect}"
      end
    rescue Gibbon::MailChimpError => e
      puts "Mailchimp API Error: #{e.title} - #{e.detail}"
    rescue StandardError => e
      puts "An unexpected error occurred: #{e.message}"
    end
  end
end
