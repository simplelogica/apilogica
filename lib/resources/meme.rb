module Resources
  class Meme < Base
    # Freeze memes hash on load
    AVAILABLE_MEMES = YAML.load(File.open(File.join(File.dirname(__FILE__), "../assets/meme/meme_image_names.yml"))).freeze
    CUSTOM_MEMES = YAML.load(File.open(File.join(File.dirname(__FILE__), "../assets/meme/custom_image_names.yml"))).freeze

    def request(query)
      url = self.resource_url(query)
      response = http_request(url)
      {image: response['imageUrl']}
    end

    def help
      "#{@api_resource.name} 'meme name' | 'top text' | 'bottom text'. " \
      "Available memes: #{AVAILABLE_MEMES.merge(CUSTOM_MEMES).keys.join(', ')}"
    end

    # URL for memecaptain
    # http://v1.memecaptain.com/
    def resource_url(query)
      self.generate_url(query)
    rescue
      self.help
    end

    def extract_matches_from_query(query)
      #1: meme_name; 2: up_text; 3: down_text
      matches = query.split("|").map(&:strip)
      [matches[0], (matches[1] || ""), (matches[2] || "")]
    end

    def generate_url(query)
      meme_name, up_text, down_text = self.extract_matches_from_query(query)
      if AVAILABLE_MEMES.keys.include?(meme_name)
        self.generate_regular_url(meme_name, up_text, down_text)
      elsif CUSTOM_MEMES.keys.include?(meme_name)
        self.generate_custom_url(meme_name, up_text, down_text)
      else
        raise StandardError.new
      end
    end

    def generate_custom_url(meme_name, up_text, down_text)
      "http://v1.memecaptain.com/g?u=#{CUSTOM_MEMES[meme_name]}&t1=#{up_text}&t2=#{down_text}"
    end

    def generate_regular_url(meme_name, up_text, down_text)
      "#{@api_resource.endpoint}/"\
      "g?u=http://v1.memecaptain.com/"\
      "#{AVAILABLE_MEMES[meme_name]}"\
      "&t1=#{up_text}"\
      "&t2=#{down_text}"
    end

  end
end
