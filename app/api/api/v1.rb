class API
  class V1 < Grape::API
    version 'v1', using: :path, vendor: 'apilogica'

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

    resource :services do
      route_param :id do
        desc 'Make a query for a resource' do
          detail 'Returns the result of query for a resource.'
        end
        params do
          use :query
        end
        get do
          service_name = params[:id]
          api_service = ApiService.where(name: service_name).last
          if api_service
            service = api_service.get_service params
            resource_name, query = params[:text].split(' ', 2)
            api_resource = ApiResource.where(name: resource_name).last
            if api_resource
              resource = api_resource.get_resource
              resource_response = resource.request query
              service_response = service.request image: resource_response
              status service_response.code
            else
              status 404
            end
          else
            status 404
          end
        end
      end
    end
  end
end
