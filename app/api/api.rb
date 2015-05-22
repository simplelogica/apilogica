class API < Grape::API
  format :json
  # Specific content type to set UTF-8 and avoid codification problems
  content_type :json, 'application/json; charset=UTF-8'

  mount API::V1
end
