require 'faraday'

module Bond
  class Connection
    attr_accessor :connection

    class << self
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