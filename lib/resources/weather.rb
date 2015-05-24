module Resources
  class Weather < Base
    # URL for OpenWeatherMap endpoint
    # http://openweathermap.org/api
    def help
      "#{@api_resource.name} 'city[,country]'"
    end

    def resource_url query
      "http://api.openweathermap.org/data/2.5/weather?q=#{query}&lang=es&units=metric"
    end

    def request query
      url = resource_url query
      response = http_request url
      icon_name = response['weather'].first()['icon']
      return {
        image: "http://openweathermap.org/img/w/#{icon_name}.png",
        pretext: description(response)
      }
    end

    def description response
      city_name = response['name']
      temp_min = response['main']['temp_min']
      temp_max = response['main']['temp_max']
      humidity = response['main']['humidity']
      wind = response['wind']['speed']
      "*El tiempo en #{city_name}*\n*Temp*: min #{temp_min}º, max #{temp_max}º\n*Humedad*: #{humidity}%\n*Viento*: #{wind}km/h"
    end
  end
end
