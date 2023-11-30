require 'rails_helper'

RSpec.describe 'API::V1::VerificationRequests', type: :request do
  describe 'POST /api/v1/verification_requests/create_verification_request' do
    it 'creates a verification request and sends OTP' do
      form = create(:form)
      phone_number = '+1234567890'

      expect do
        post '/api/v1/verification_requests/create_verification_request', params: {
          form_id: form.id,
          phone_number: phone_number
        }
      end.to change { VerificationRequest.count }.by(1)
        .and change { Subscriber.count }.by(1)

      expect(response).to have_http_status(:success)
      json_response = JSON.parse(response.body)
      expect(json_response['status']).to eq('OTP sent')
      expect(json_response['subscriber_uuid']).to be_present
      expect(json_response['form_uuid']).to eq(form.uuid)
    end
  end

  describe 'POST /api/v1/verification_requests/verify_otp' do
    it 'verifies OTP and returns success' do
      subscriber = create(:subscriber)
      form = create(:form)
      verification_request = create(:verification_request, subscriber: subscriber, form: form)

      post '/api/v1/verification_requests/verify_otp', params: {
        subscriber_id: subscriber.id,
        form_id: form.id,
        user_provided_otp: verification_request.otp_code
      }

      expect(response).to have_http_status(:success)
      json_response = JSON.parse(response.body)
      expect(json_response['status']).to eq('OTP verified')
    end

    it 'fails to verify OTP and returns failure' do
      subscriber = create(:subscriber)
      form = create(:form)
      verification_request = create(:verification_request, subscriber: subscriber, form: form)

      post '/api/v1/verification_requests/verify_otp', params: {
        subscriber_id: subscriber.id,
        form_id: form.id,
        user_provided_otp: '123456'
      }

      expect(response).to have_http_status(:success)
      json_response = JSON.parse(response.body)
      expect(json_response['status']).to eq('OTP not verified')
    end
  end
end
