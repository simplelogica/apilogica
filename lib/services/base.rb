module Services
  class Base
    # Attributes for resource and query send by the service
    # that needs to be parsed in each service
    attr_accessor :resource_name, :query

    def initialize api_service, params
      @api_service = api_service
      parse_params params
    end

    # Overwrite this method to get params from http request
    def parse_params params
      @resource_name = ''
      @query = ''
      @options = {}
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

    # Do the request to the resource send to the service
    # and returns the status code
    def request_resource
      api_resource = ApiResource.where(name: resource_name).last
      if api_resource
        resource = api_resource.get_resource
        resource_response = resource.request query
        request image: resource_response
      else
        Net::HTTPNotFound.new
      end
    end
  end
end