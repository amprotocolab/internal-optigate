require 'rails_helper'

RSpec.xdescribe 'Passwords API' do
  let(:password) { 'password' }

  describe 'GET: /api/v1/auth/password/edit' do
    let(:redirect_url) { 'https://google.com' }
    let!(:user) { create(:user, reset_password_token: '145236545') }
    let!(:params) do
      {
        config:               'default',
        redirect_url:         redirect_url,
        reset_password_token: user.reset_password_token
      }
    end

    before do
      allow(User).to receive(:with_reset_password_token).and_return(user)
    end

    context 'when reset password token is invalid' do
      before { allow_any_instance_of(User).to receive(:reset_password_period_valid?).and_return(false) }

      it 'returns invalid token error message' do
        get '/api/v1/auth/password/edit', params: params

        expect(json_response).to include(
          success: false,
          errors:  ['Invalid or expired reset password token']
        )
      end
    end

    context 'when reset password token is valid' do
      before { allow_any_instance_of(User).to receive(:reset_password_period_valid?).and_return(true) }

      it 'redirects to the specified link with auth headers in redirected link' do
        get '/api/v1/auth/password/edit', params: params

        expect(CGI.unescapeHTML(response.body)).to include(redirect_url)
        expect(CGI.unescapeHTML(response.body)).to include('access-token')
        expect(CGI.unescapeHTML(response.body)).to include('client')
        expect(CGI.unescapeHTML(response.body)).to include('config')
        expect(CGI.unescapeHTML(response.body)).to include('expiry')
        expect(CGI.unescapeHTML(response.body)).to include('reset_password')
        expect(CGI.unescapeHTML(response.body)).to include('uid')
      end
    end
  end
end
