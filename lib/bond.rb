require_relative 'bond/version'
require_relative 'bond/connection'
require_relative 'bond/errors'
require_relative 'bond/account'
require_relative 'bond/order'
require_relative 'bond/message'
require_relative 'bond/preview'
require_relative 'bond/preview/message_preview'
require_relative 'bond/preview/envelope_preview'


module Bond
  API_URL = 'https://api.bond.co'

  # @param [String] key
  def self.api_key=(key)
    @api_key = key
  end

  # @return [String]
  def self.api_key
    @api_key
  end
end
