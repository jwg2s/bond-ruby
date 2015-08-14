module Bond
  class BondError < StandardError
    attr_reader :http_code, :application_error_code

    class << self
      # @param [Hash] json
      def handle_errors(json)
        errors = json['errors']
        raise Bond::BondError.new(errors.map { |error| "Code: #{error['code']}. Message: #{error['message']}" }.join(' ')) if errors
      end
    end

    def initialize(message, http_code = nil, error_code = application_error_code)
      @http_code = http_code
      @application_error_code = error_code
      super(message)
    end
  end
end