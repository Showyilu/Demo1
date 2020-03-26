module ExceptionHandler
  extend ActiveSupport::Concern

  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end

  included do
    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
    rescue_from ExceptionHandler::MissingToken, with: :unauthorized_request
    rescue_from ExceptionHandler::InvalidToken, with: :unauthorized_request

    rescue_from ActiveRecord::RecordNotFound do |e|
      render(json: e.message, status: :not_found)
    end
  end

  private

  # JSON response with message; Status code 401 - Unauthorized
  def unauthorized_request(error)
    render(json: error.message, status: :unauthorized)
  end
end
