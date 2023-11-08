VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.ignore_hosts('github.cxsfv', 'google.cxsfv', 'google.cxfsv')
  c.default_cassette_options = {
    record:            ENV.fetch('VCR_RECORD', 'none').to_sym,
    match_requests_on: [:method, VCR.request_matchers.uri_without_params(:timestamp, :access_token, :appsecret_proof)]
  }
  c.allow_http_connections_when_no_cassette = true

  [
    ['SENDGRID_API_KEY', '<SENDGRID_API_KEY>'],
    ['SENDGRID_SEND_TO_FRIEND_TEMPLATE_ID', '<SENDGRID_SEND_TO_FRIEND_TEMPLATE_ID>'],
    ['SENDGRID_TERRA_MATCH_TEMPLATE_ID', '<SENDGRID_TERRA_MATCH_TEMPLATE_ID>'],
  ].each do |var_name, var_value|
    if ENV.fetch(var_name, false)
      c.filter_sensitive_data(var_value) { ENV.fetch(var_name) }
    end
  end
end

RSpec.configure do |config|
  config.before do
    if ENV['VCR_RERECORD']
      FileUtils.rm_f(VCR.current_cassette.file) if VCR.current_cassette
    end
  end
end
