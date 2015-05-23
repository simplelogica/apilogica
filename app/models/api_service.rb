################
# Class for services that request resources
################
class ApiService
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :token, type: String
  field :callback_url, type: String
end
