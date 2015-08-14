require_relative 'bond/version'
require_relative 'bond/account'
require_relative 'bond/order'
require_relative 'bond/preview'


module Bond
  API_URL = 'https://api.hellobond.com'

  def self.api_key=(key)
    @api_key = key
  end

  def self.api_key
    @api_key
  end
end
