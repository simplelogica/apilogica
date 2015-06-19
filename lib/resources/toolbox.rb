module Resources
  class Toolbox < Base
    # URL for SlToolbox endpoint
    # http://sl-toolbox.herokuapp.com/api/v1/resources
    def resource_url query
        self.generate_url(query)
      rescue
        self.help
    end

    def help
      "#{@api_resource.name} 'sltoolbox action [options]' " +
      "| Available actions: search tag " +
      "| save url,tag_list (separated by commas)"
    end

    def generate_url(query)
      action = query.split(" ")[0]
      params = query.split(" ")[1..-1].join("")

      if action == 'search'
        "#{@api_resource.endpoint}?action=search&query=#{params}"
      elsif action == 'save'
        "#{@api_resource.endpoint}?action=save&query=#{params}&user='apilogica@simplelogica.net'"
      else
        nil
      end
    end

    def request query
      url = resource_url query
      response = http_request url
      if response['resource_url'].present?
        {
          title: "¡Enlace almacenado en SlToolbox! Pincha aquí para verlo",
          title_link: response['url']
        }
      elsif response['url'].present?
        {
          title: "Pincha aquí para ver el resultado de la búsqueda en SlToolbox",
          title_link: response['url']
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
