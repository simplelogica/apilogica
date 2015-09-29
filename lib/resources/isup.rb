module Resources
  class IsUp < Base
    # URL for IsUp cheking service
    # http://isup.me/
    def resource_url query
      "#{@api_resource.endpoint}/#{query}"
    end

    def help
      "#{@api_resource.name} 'domain_to_check'"
    end

    def request query
      url = resource_url query
      response = http_request url, :raw

      if !response.blank?
        if (response.include?("It's just you"))
          title: "It appears that #{query} is UP from here",
          text: "Maybe you have some DNS or network issue..."
        else
          title: "It isn\'t just you! It appears that #{query} is DOWN from here",
          text: "The domain wasn't available when trying to access it from isup.me service."
        end
      else
        {
          title: "Couldn't check #{query} domain",
          text: 'Upsssss... We couldn\'t connect to the checking service.',
          image: 'http://www.eadlf.com/wp-content/uploads/2012/06/chiquito.gif'
        }
      end
    end
  end
end
