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

      def find(guid)
        conn = Faraday.new(url: Bond::API_URL)
        conn.basic_auth(Bond.api_key, nil)
        response = conn.get("/orders/#{guid}")
        attributes = JSON.parse(response.body)['data']
        new(attributes)
      end

      def create
        conn = Faraday.new(url: Bond::API_URL)
        conn.basic_auth(Bond.api_key, nil)
        response = conn.post('/orders')
        attributes = JSON.parse(response.body)['data']
        new(attributes)
      end
    end

    # @param [Hash] attributes
    def initialize(attributes = {})
      attributes.each { |name, value| instance_variable_set("@#{name}", value) }
    end

    def process
      conn = Faraday.new(url: Bond::API_URL)
      conn.basic_auth(Bond.api_key, nil)
      response = conn.post("/orders/#{guid}/process")
      attributes = JSON.parse(response.body)['data']
      attributes.each { |name, value| instance_variable_set("@#{name}", value) }
      self.links = JSON.parse(response.body)['links']
      self
    end
  end
end
