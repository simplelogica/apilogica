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

  def kind_enum
    [['Slack', 'Services::Slack']]
  end
end
