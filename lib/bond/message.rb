require 'faraday'
require 'json'

module Bond
  class Message
    attr_accessor :guid, :stationary_id, :handwriting, :content, :recipient_address, :sender_address, :links

    # @param [Hash] attributes
    def initialize(attributes = {})
      attributes.each { |name, value| instance_variable_set("@#{name}", value) }
    end
  end
end