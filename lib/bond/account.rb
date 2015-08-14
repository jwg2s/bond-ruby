require 'faraday'
require 'json'

module Bond
  class Account
    attr_accessor :first_name,
                  :last_name,
                  :email,
                  :credits,
                  :links

    def initialize
      conn = Faraday.new(url: Bond::API_URL)
      conn.basic_auth(Bond.api_key, nil)
      response = conn.get('/account')

      attributes = JSON.parse(response.body)

      @first_name = attributes['data']['first_name']
      @last_name = attributes['data']['last_name']
      @email = attributes['data']['email']
      @credits = attributes['data']['credits']
      @links = attributes['links']
    end
  end
end