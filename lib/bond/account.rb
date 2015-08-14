require 'faraday'
require 'json'

module Bond
  class Account
    attr_accessor :first_name, :last_name, :email, :credits, :links

    def initialize
      response = Bond::Connection.connection.get('/account')
      json = JSON.parse(response.body)

      Bond::BondError.handle_errors(json)

      json['data'].each { |name, value| instance_variable_set("@#{name}", value) }
      @links = json['links']
    end
  end
end