require 'faraday'
require 'json'

module Bond
  class MessagePreview < Preview
    attr_accessor :encoded_content, :encoded_content_hash, :encoded_content_timestamp, :img

    # @return [Hash] attributes
    def request_preview
      response = Bond::Connection.connection.post('/messages/preview/content', request_params)
      json = JSON.parse(response.body)

      Bond::BondError.handle_errors(json)

      attributes = json['data']
      attributes.each { |name, value| instance_variable_set("@#{name}", value) }
      attributes
    end
  end
end