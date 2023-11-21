require 'rails_helper'

RSpec.describe 'Contact' do
  include_context 'GraphQL test'

  describe 'createContact' do
    let(:new_first_name) { 'John' }
    let(:new_last_name) { 'Doe' }
    let(:new_email) { 'john.doe@example.com' }
    let(:new_contact_number) { '1234567890' }
    let(:new_message) { 'Hello, this is a test message.' }

    let(:query) do
      <<~GRAPHQL
        mutation {
          createContact(
            input: {
              firstName: "#{new_first_name}"
              lastName: "#{new_last_name}"
              email: "#{new_email}"
              contactNumber: "#{new_contact_number}"
              message: "#{new_message}"
              uid: "#{SecureRandom.uuid}"
            }
          ) {
            message
          }
        }
      GRAPHQL
    end

    it 'creates a contact' do
      expect do
        response
      end.to change(Contact, :count).by(1)

      expect(response.dig(:data, :createContact)).to include(
        message: 'Contact Information has been processed successfully.'
      )
    end
  end
end
