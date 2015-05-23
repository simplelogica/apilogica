class ApiResource
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :api_key, type: String
  field :endpoint, type: String
  field :kind, type: String

  def get_resource
    kind.constantize.new self
  end
end
