module Resources
  class Imdb < Base

    def request query
      url = self.resource_url query
      response = http_request url
      self.parse_response response
    end

    def help
      "#{@api_resource.name} 'movie name'"
    end

    def resource_url query
      "#{@api_resource.endpoint}/?t=#{query}"
    end

    def parse_response response
      if response['Response'] == 'False'
        {
          image: 'http://fc03.deviantart.net/fs71/f/2012/201/e/4/error_404__file_not_found__by_mortimermcmirestinks-d580e1k.gif'
        }
      else
        {
          title: "Ficha en IMDB",
          title_link: "http://www.imdb.com/title/#{response['imdbID']}/",
          image: response['Poster'],
          pretext: create_description(response),
        }
      end
    end

    def create_description response
      "*Titulo*: #{response['Title']}\n"\
      "*Año*: #{response['Year']}\n"\
      "*Duración*: #{response['Runtime']}\n"\
      "*Género*: #{response['Genre']}\n"\
      "*Argumento*: #{response['Plot']}\n"\
      "*Director*: #{response['Director']}\n"\
      "*Actores*: #{response['Actors']}\n"\
      "*Premios*: #{response['Awards']}\n"\
      "*Calificación*: #{response['imdbRating']}\n"\
    end

  end
end
