shared_examples 'an unprocessable request' do |http_method, endpoint, expected_code = 'unprocessable'|
  it "returns #{expected_code}" do
    request_params = defined?(attrs) ? attrs : {}
    url_params     = defined?(request_info) ? request_info : {}

    public_send(
      http_method,
      full_endpoint(endpoint, url_params),
      headers: auth_headers_for(user),
      params: request_params
    )

    expect(response).to be_json & public_send("be_#{expected_code}")
  end
end
