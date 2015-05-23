module Resources
  class Giphy < Base
    # URL for Giphy random endpoint
    # http://api.giphy.com/v1/gifs/random
    def resource_url query
      "#{@api_resource.endpoint}?q=#{query}&api_key=#{@api_resource.api_key}"
    end

    def request query
      url = resource_url query
      response = http_request url
      response['data']['image_original_url']
    end
  end
end
