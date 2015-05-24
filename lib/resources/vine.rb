module Resources
  class Vine < Base
    # URL for Vine random endpoint
    # https://api.vineapp.com/timelines/tags
    def resource_url query
      "#{@api_resource.endpoint}/#{query}"
    end

    def help
      "#{@api_resource.name} 'tag'"
    end

    def request query
      url = resource_url query
      response = http_request url
      if response['data'] && response['data']['records'].any?
        records = response['data']['records'].count
        record = rand(0..records-1)
        {
          title: "Random ##{query} Vine",
          title_link: response['data']['records'][record]['permalinkUrl'],
          text: response['data']['records'][record]['permalinkUrl'],
          image: response['data']['records'][record]['thumbnailUrl']
        }
      else
        {
          title: "Random ##{query} Vine",
          title_link: 'https://vine.co/v/hHDi56lJ9AO',
          text: 'Upsssss...',
          image: 'http://www.eadlf.com/wp-content/uploads/2012/06/chiquito.gif'
        }
      end
    end
  end
end
