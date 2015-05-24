module Resources
  class Base
    def initialize api_resource
      @api_resource = api_resource
    end

    def help
      "#{@api_resource.name} don't has help yet"
    end

    def http_request url, limit = 10
      uri = URI.parse url
      http = Net::HTTP.new(uri.host, uri.port)
      if uri.scheme == 'https'
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end
      request = Net::HTTP::Get.new(uri.to_s)
      response = http.request(request)
      # Handle redirections
      case response
      when Net::HTTPSuccess     then ActiveSupport::JSON.decode(response.body)
      when Net::HTTPRedirection then http_request(response['location'], limit - 1)
      end
    end
  end
end
