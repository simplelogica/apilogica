module Resources
  class SlToolbox < Base
    # URL for SlToolbox random endpoint
    # http://sl-toolbox.herokuapp.com
    def resource_url query
      "#{@api_resource.endpoint}/#{query}"
    end

    def help
      "#{@api_resource.name} 'sltoolbox action [options]'" \
      "Available actions: search tag" \
      "                   save url,tag_list (separated by commas)"
    end

    def request query
      url = resource_url query
      response = http_request url
      if response['data'] && response['data']['resource_url'].present?
        records = response['data']['records'].count
        record = rand(0..records-1)
        {
          title: "¡Enlace almacenado en SlToolbox! Pincha aquí para verlo",
          title_link: response['data']['url']
        }
      elsif response['data'] && response['data']['url'].present?
        {
          title: "Búsqueda en SlToolbox con tags",
          title_link: response['data']['url']
        }
      else
        {
          title: "SlToolbox Error",
          title_link: 'https://vine.co/v/hHDi56lJ9AO',
          text: 'Upsssss...',
          image: 'http://www.eadlf.com/wp-content/uploads/2012/06/chiquito.gif'
        }
      end
    end
  end
end
