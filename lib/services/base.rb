module Services
  HELP_OPTION = '-help'.freeze

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
      if resource_name == HELP_OPTION
        "Available resources: #{ApiResource.pluck(:name).to_sentence}"
      else
        if api_resource
          resource = api_resource.get_resource
          if query == HELP_OPTION
            resource.help
          else
            resource_response = resource.request query
            request resource_response
          end
        else
          Net::HTTPNotFound.new(1.0, 404, "NOT FOUND")
        end
      end
    end
  end
end
