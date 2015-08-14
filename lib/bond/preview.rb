require 'faraday'
require 'json'

module Bond
  class Preview
    attr_accessor :request_params

    # @param [Hash] attributes
    def initialize(attributes = {})
      @request_params = attributes
    end

    # @return [Hash] attributes
    def request_preview
      raise 'Subclass must implement this method'
    end
  end
end