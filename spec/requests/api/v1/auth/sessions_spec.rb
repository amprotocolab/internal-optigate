require 'rails_helper'

RSpec.describe 'Sessions API' do
  let(:user) { create(:user, :agency_admin) }

  describe 'POST: /api/v1/auth/sign_in' do
    it 'signs in' do
      post '/api/v1/auth/sign_in',
        params: {
          email: user.email,
          password: user.password
        }

      expect(response).to be_json
      expect(json_response).to include(
        uuid: user.uuid,
        first_name: user.first_name,
        last_name: user.last_name,
        email: user.email
      )
      expect(response.headers['uid']).to match(user.uid)
      expect(response.headers).to include('client', 'access-token')
      expect(response).to be_successful
    end
  end

  describe 'DELETE: /api/v1/auth/sign_out' do
    it 'signs out' do
      delete '/api/v1/auth/sign_out',
        headers: auth_headers_for(user)

      expect(json_response).to include(success: true)
      expect(response.headers).not_to include('uid', 'client', 'access-token')
      expect(response).to be_successful
    end
  end

  # describe 'POST: /api/v1/auth/okta/callback' do

  #   let!(:payload) {
  #     {
  #       "omniauth.auth":{
  #         "sub": "00uow5db2eF1qOLbu357",
  #         "name": "test, test",
  #         "locale": "US",
  #         "info": {
  #           "email": "test@xyz.com",
  #           "first_name": "test",
  #           "last_name": "test"
  #         },
  #         "zoneinfo": "America/Los_Angeles",
  #         "updated_at": 1674221625,
  #         "email_verified": true,
  #         "headers": {
  #           "cache-control": "no-cache, no-store",
  #           "content-type": "application/json",
  #           "date": "Tue, 24 Jan 2023 15:21:04 GMT",
  #           "expires": "0",
  #           "pragma": "no-cache",
  #           "x-okta-request-id": "Y8_3YEtk_9O2WQIRblJdQQAABeY",
  #           "x-rate-limit-limit": "2000",
  #           "x-rate-limit-remaining": "1999",
  #           "x-rate-limit-reset": "1674573724"
  #         }
  #       }
  #     }
  #   }
  #   # let!(:headers) do
  #   #   { HTTP_AUTHORIZATION: 'Bearer testvalidaccesstoken' }
  #   # end

  #   # before do
  #   #   post '/api/v1/auth/:okta/callback', params: payload, headers: headers
  #   # end

  #   # it 'signs in', vcr: { cassette_name: 'valid_access_token_api_request' } do

  #   #   expect(response).to be_json
  #   #   expect(response).to be_successful
  #   #   expect(json_response).to match(
  #   #     hash_including(
  #   #       stores:                [],
  #   #       roles:                 [hash_including(name: Role::PERMITTED.fetch(:territory_manager))],
  #   #       auth_token:            be_a_kind_of(String),
  #   #       client_id:             be_a_kind_of(String),
  #   #       email:                 payload[:'omniauth.auth'][:'info'][:'email'],
  #   #       first_name:            payload[:'omniauth.auth'][:'info'][:'first_name'],
  #   #       last_name:             payload[:'omniauth.auth'][:'info'][:'last_name'],
  #   #       provider:              'email',
  #   #       uid:                   'test@xyz.com',
  #   #       employee:              true,
  #   #       alerts:                false,
  #   #       allow_password_change: false,
  #   #       config:                nil,
  #   #       oauth_registration:    true,
  #   #       phone_number:          nil
  #   #     )
  #   #   )
  #   # end
  # end
end
