class ApiResource
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :api_key, type: String
  field :endpoint, type: String
  field :kind, type: String

  def get_resource
    Resources.const_get(kind).new self
  end

  # Gets resources dynamically from module for rails admin selection
  def kind_enum
    # Only classes and base class can't be selected
    Resources.constants.select do |c|
      Resources.const_get(c).is_a?(Class) && c != :Base
    end
  end
end
