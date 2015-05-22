class API
  class V1 < Grape::API
    version 'v1', using: :path, vendor: 'acutario'

    helpers do
      params :service do
        optional :service, type: String, default: nil,
                        documentation: {
                          type: 'string',
                          desc: 'Defines de format response for a service'
                        }
      end

      params :query do
        optional :query, type: String, default: nil,
                        documentation: {
                          type: 'string',
                          desc: 'Query for the resource'
                        }
      end
    end

    resource :resources do
      desc 'Returns a list of suported resources.' do
        detail 'The work settings include their holidays of a year.'
      end
      get do
        ['test']
      end

      route_param :id do
        desc 'Make a query for a resource' do
          detail 'Returns the result of query for a resource.'
        end
        params do
          use :service
          use :query
        end
        get do
          { message: 'Test resource'}
        end
      end
    end
  end
end
