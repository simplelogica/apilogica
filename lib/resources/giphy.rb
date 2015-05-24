module Resources
  class Giphy < Base
    # URL for Giphy random endpoint
    # http://api.giphy.com/v1/gifs/random
    def resource_url query
      "#{@api_resource.endpoint}?tag=#{query}&api_key=#{@api_resource.api_key}"
    end

    def help
      "#{@api_resource.name} 'query'"
    end

    def request query
      url = resource_url query
      response = http_request url
      if response['data'] && response['data'].any?
        response['data']['image_original_url']
      else
        'http://fc03.deviantart.net/fs71/f/2012/201/e/4/error_404__file_not_found__by_mortimermcmirestinks-d580e1k.gif'
      end
    end
  end
end
