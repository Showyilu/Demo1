# frozen_string_literal: true

class AuthenticationService < BaseService
  def initialize(headers = {})
    super()

    @headers = headers
  end

  def run
    success(user)
  end

  private

  attr_reader :headers

  def user
    @user ||= user_from_auth_token
  end

  def user_from_auth_token
    User.find(decoded_token.dig("data", "user_id"))
  rescue JWT::DecodeError
    raise "Invalid Token"
  end

  def auth_header
    headers["Authorization"].presence
  end

  def decoded_token
    JSONWebToken::AccessToken.decoded_token(auth_token)
  end

  def auth_token
    return auth_header.split(" ").last if auth_header.present?

    raise "Missing Token"
  end
end
