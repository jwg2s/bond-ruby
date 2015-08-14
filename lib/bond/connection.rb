require 'faraday'

module Bond
  class Connection
    attr_accessor :connection

    class << self
      # Create instances of connection object to ensure thread safety
      # @return [Faraday] connection
      def connection
        new.connection
      end
    end

    def initialize
      connection = Faraday.new(url: Bond::API_URL)
      connection.basic_auth(Bond.api_key, nil)
      @connection = connection
    end
  end
end