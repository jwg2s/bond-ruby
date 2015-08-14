require 'faraday'
require 'json'

module Bond
  class EnvelopePreview
    attr_accessor :encoded_envelope, :encoded_envelope_hash, :encoded_envelope_timestamp, :img, :request_params

    # @param [Hash] attributes
    def initialize(attributes = {})
      @request_params = attributes
    end

    def request_preview
      response = Bond::Connection.connection.post('/messages/preview/envelope', request_params)
      json = JSON.parse(response.body)

      Bond::BondError.handle_errors(json)

      attributes = json['data']
      attributes.each { |name, value| instance_variable_set("@#{name}", value) }
    end
  end
end