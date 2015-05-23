module Resources
  class Meme < Base
    # URL for memecaptain
    # http://v1.memecaptain.com/
    def resource_url(query)
      name_photo = self.get_name_photo_from_query(query)
      up_text, down_text = self.get_text_from_query(query)
      "#{@api_resource.endpoint}g?u=http%3A%2F%2Fv1.memecaptain.com%2F#{photo}&t1=#{up_text}&t2=#{down_text}"
    end

    def request(query)
      url = self.resource_url(query)
      response = http_request(url)
      response['imageUrl']
    end

    def get_name_photo_from_query(query)
    end

    def get_text_from_query(query)
    end
  end
end
