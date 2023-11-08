module Requests
  module UrlHelpers
    def full_endpoint(endpoint, url_params)
      new_endpoint = endpoint.dup
      url_params.each { |k, v| new_endpoint.gsub!("/:#{k}", "/#{v}") }

      new_endpoint
    end
  end
end
