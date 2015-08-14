module Bond
  class BondError < StandardError
    attr_reader :http_code, :application_error_code

    class << self
      # @param [Hash] json
      def handle_errors(json)
        errors = json['errors']
        if errors
          error_message = errors.map { |error| "Code: #{error['code']}. Message: #{error['message']}" }.join(' ')
          raise Bond::BondError.new(error_message)
        end
      end
    end

    # @param [String] message
    def initialize(message)
      super(message)
    end
  end
end