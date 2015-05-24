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
    Services.const_get(kind).new self, params
  end

  # Gets services dynamically from module for rails admin selection
  def kind_enum
    # Only classes and base class can't be selected
    Services.constants.select do |c|
      Services.const_get(c).is_a?(Class) && c != :Base
    end
  end
end
