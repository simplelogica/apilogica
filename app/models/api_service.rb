################
# Class for services that request resources
################
class ApiService
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :token, type: String
  field :callback_url, type: String
  field :kind, type: String

  def get_service params
    kind.constantize.new self, params
  end

  # Gets services dynamically from module for rails admin selection
  def kind_enum
    services = Services.constants
    # Base class couldn't be selected
    services.delete :Base
    services.map { |service| [service, "Services::#{service}"] }
  end
end
