module Resources
  class Base
    def initialize api_resource
      @api_resource = api_resource
    end

    def help
      "#{@api_resource.name} don't has help yet"
    end

    def http_request url, format = :json, limit = 10
      uri = URI.parse Utils.encode_url(url)
      http = Net::HTTP.new(uri.host, uri.port)
      if uri.scheme == 'https'
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end
      request = Net::HTTP::Get.new(uri.to_s)
      response = http.request(request)
      # Handle redirections
      case response
      when Net::HTTPSuccess 
        case format 
        when :json then ActiveSupport::JSON.decode(response.body)
        when :raw then response.body
        end
      when Net::HTTPRedirection then http_request(response['location'], limit - 1)
      end
    end
  end
end
