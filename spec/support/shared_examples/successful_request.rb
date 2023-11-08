shared_examples 'a successful request' do |http_method, endpoint, json = true|
  describe "#{http_method.upcase} #{endpoint}" do
    it 'returns success' do
      request_params = defined?(attrs) ? attrs : {}
      url_params     = defined?(request_info) ? request_info : {}

      public_send(
        http_method,
        full_endpoint(endpoint, url_params),
        headers: auth_headers_for(user),
        params: request_params
      )

      expect(response).to be_successful
      expect(response).to be_json if json
    end
  end
end
