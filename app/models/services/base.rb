module Services
  class Base
    def initialize api_service
      @api_service = api_service
    end

    def http_request url, data
      uri = URI.parse url
      http = Net::HTTP.new(uri.host, uri.port)
      if uri.scheme == 'https'
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end
      request = Net::HTTP::Post.new(uri.request_uri)
      request.set_form_data(data)
      http.request(request)
    end
  end
end
