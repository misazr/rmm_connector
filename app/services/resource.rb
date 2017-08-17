require 'rest_in_peace'
require 'faraday'
require 'faraday_middleware'

class Resource
  include RESTinPeace

  rest_in_peace do
    use_api ->() do
      ::Faraday.new(url: 'http://localhost:3003', headers: { 'Accept' => 'application/json'}) do |faraday|
        faraday.request :json, :content_type => /\bjson$/
        faraday.response :json, :content_type => /\bjson$/
      end
    end

    attributes do
      read :id
    end

    resource do
      get :status, '/v1/power/:id/status.json'
    end
  end
end
