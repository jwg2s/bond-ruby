require 'faraday'
require 'json'

module Bond
  class Order
    attr_accessor :guid, :created_at, :status, :products, :shipping, :total, :links

    class << self
      # @param [Hash] options
      # @return [Array<Bond::Order>]
      def all(options = {})
        page = options[:page]
        response = Bond::Connection.connection.get("/orders?page=#{page || 1}")

        JSON.parse(response.body)['data'].map do |attributes|
          new(attributes)
        end
      end

      # @return [Hash]
      def pagination
        @pagination ||= begin
          response = Bond::Connection.connection.get('/orders')
          JSON.parse(response.body)['pagination'] || {}
        end
      end

      # @param [String] guid
      # @return [Bond::Order]
      def find(guid)
        response = Bond::Connection.connection.get("/orders/#{guid}")
        attributes = JSON.parse(response.body)['data']
        new(attributes)
      end

      # @return [Bond::Order]
      def create
        response = Bond::Connection.connection.post('/orders')
        json = JSON.parse(response.body)

        Bond::BondError.handle_errors(json)

        attributes = json['data']
        new(attributes)
      end
    end

    # @param [Hash] attributes
    def initialize(attributes = {})
      attributes.each { |name, value| instance_variable_set("@#{name}", value) }
    end

    # @return [Boolean]
    def process
      response = Bond::Connection.connection.post("/orders/#{guid}/process")
      json = JSON.parse(response.body)

      Bond::BondError.handle_errors(json)

      attributes = json['data']
      attributes.each { |name, value| instance_variable_set("@#{name}", value) }
      self.links = json['links']
      response.success?
    end

    # @param [Hash] message_hash
    # @return [Boolean]
    def add_message(message_hash)
      response = Bond::Connection.connection.post("/orders/#{guid}/messages", message_hash)

      @messages = nil
      response.success?
    end

    # @return [Array<Bond::Message>]
    def messages
      @messages ||= begin
        response = Bond::Connection.connection.get("/orders/#{guid}/messages")
        messages = JSON.parse(response.body)['data']
        messages.map do |attributes|
          Message.new(attributes)
        end
      end
    end

    # @return [Hash]
    def message_pagination
      @message_pagination ||= begin
        response = Bond::Connection.connection.get("/orders/#{guid}/messages")
        JSON.parse(response.body)['pagination'] || {}
      end
    end
  end
end
