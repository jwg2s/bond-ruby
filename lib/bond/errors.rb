module Bond

  # Base class exception from which all public Bond exceptions will be derived
  class BondError < StandardError
    attr_reader :http_code, :application_error_code

    def initialize(message, http_code = nil, error_code = application_error_code)
      @http_code = http_code
      @application_error_code = error_code
      super(message)
    end
  end

  # Raised when the credentials you provide don't match a valid account on Bond.
  # Check that you have set Bond.api_key= correctly.
  class AuthenticationError < BondError
  end

  # Raised when requesting resources on behalf of a user that doesn't exist in your application on Bond.
  class ResourceNotFound < BondError
  end

  # Raised when the request has a bad syntax
  class BadRequestError < BondError
  end

  # Raised when the request throws an error not accounted for
  class UnexpectedError < BondError
  end

  # Raised when unexpected nil returned from server
  class Bond::HttpError < BondError
  end
end