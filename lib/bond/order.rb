require 'faraday'
require 'json'

module Bond
  class Order
    attr_accessor :guid, :created_at, :status, :products, :shipping, :total, :links

    class << self
      def all
        conn = Faraday.new(url: Bond::API_URL)
        conn.basic_auth(Bond.api_key, nil)
        response = conn.get('/orders')

        JSON.parse(response.body)['data'].map do |attributes|
          new(attributes)
        end
      end

      def find(id)
        conn = Faraday.new(url: Bond::API_URL)
        conn.basic_auth(Bond.api_key, nil)
        response = conn.get("/orders/#{id}")
        attributes = JSON.parse(response.body)['data']
        new(attributes)
      end
    end

    # @param [Hash] attributes
    def initialize(attributes = {})
      attributes.each { |name, value| instance_variable_set("@#{name}", value) }
    end
  end
end
