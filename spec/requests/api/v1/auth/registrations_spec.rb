require 'rails_helper'

RSpec.describe 'Registration API' do
  describe 'POST /api/v1/auth' do
    it 'creates a new user' do
      post '/api/v1/auth',
      params: {
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password'
      }

      expect(response).to be_json
      expect(json_response[:data]).to be_present
      expect(json_response[:data]).to include(
        email: "test@example.com"
      )
      expect(response.headers).to include('client', 'access-token')
    end

    it 'returns an error response without email and password' do
      post '/api/v1/auth',
      params: {
        password: '12345678'
      }
      expect(response).to be_json
      expect(json_response[:status]).to eql "error"
      expect(json_response[:data]).to be_present
      expect(json_response[:errors][:full_messages][0]).to eql "Email can't be blank"
      # Add additional assertions to verify the error response
    end
  end
end
