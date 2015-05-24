module Resources
  class Meme < Base
    def help
      "#{@api_resource.name} 'meme name' | 'top text' | 'bottom text'"
    end

    # URL for memecaptain
    # http://v1.memecaptain.com/
    def resource_url(query)
      matches = query.match(/(\S+)\s*\|\s*(.+)\s*\|\s*(.+)/)
      image_name = YAML.load(File.open(File.join(File.dirname(__FILE__), "../assets/meme/meme_image_names.yml")))[matches[1]]
      "#{@api_resource.endpoint}/"\
      "g?u=http%3A%2F%2Fv1.memecaptain.com%2F"\
      "#{image_name}"\
      "&t1=#{matches[2]}"\
      "&t2=#{matches[3]}"
    rescue
      "http://v1.memecaptain.com/g?u=http%3A%2F%2Fv1.memecaptain.com%2Ffirst_world_problems.jpg&t1=meme+404+error&t2=no+encuentro+lo+que+pides+%3A%27("
    end

    def request(query)
      url = self.resource_url(query)
      response = http_request(url)
      {image: response['imageUrl']}
    end
  end
end
