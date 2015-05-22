class ApiResource
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :api_key, type: String
  field :endpoint, type: String
end
