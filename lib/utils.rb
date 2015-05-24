module Utils
  # Decode a url untils is totally decodec and encode once 
  def self.encode_url url
    decoded = url
    while decoded != URI.decode(decoded) do
      decoded = URI.decode(decoded)
    end
    URI.encode decoded
  end
end
