require 'faraday'
require 'json'

module Bond
  class Order
    attr_accessor :guid, :created_at, :status, :products, :shipping, :total, :links

    class << self
      def all
        response = Bond::Connection.connection.get('/orders')

        JSON.parse(response.body)['data'].map do |attributes|
          new(attributes)
        end
      end

      def find(guid)
        response = Bond::Connection.connection.get("/orders/#{guid}")
        attributes = JSON.parse(response.body)['data']
        new(attributes)
      end

      def create
        response = Bond::Connection.connection.post('/orders')
        attributes = JSON.parse(response.body)['data']
        new(attributes)
      end
    end

    # @param [Hash] attributes
    def initialize(attributes = {})
      attributes.each { |name, value| instance_variable_set("@#{name}", value) }
    end

    def process
      response = Bond::Connection.connection.post("/orders/#{guid}/process")
      attributes = JSON.parse(response.body)['data']
      attributes.each { |name, value| instance_variable_set("@#{name}", value) }
      self.links = JSON.parse(response.body)['links']
      self
    end

    def add_message(message_hash)
      # TODO: VALIDATE MESSAGE HASH

      response = Bond::Connection.connection.post("/orders/#{guid}/messages", message_hash)

      @messages = nil
      response.success?
    end

    def messages
      @messages ||= begin
        response = Bond::Connection.connection.get("/orders/#{guid}/messages")
        messages = JSON.parse(response.body)['data']
        messages.map do |attributes|
          Message.new(attributes)
        end
      end
    end
  end
end
