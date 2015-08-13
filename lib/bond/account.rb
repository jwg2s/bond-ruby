require 'faraday'
require 'json'

module Bond
  class Account
    API_URL = 'https://api.hellobond.com'

    attr_accessor :first_name,
                  :last_name,
                  :email,
                  :credits,
                  :links

    def initialize(api_key)
      conn = Faraday.new(url: API_URL)
      conn.basic_auth(api_key, nil)
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