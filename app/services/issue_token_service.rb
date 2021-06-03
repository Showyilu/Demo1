# frozen_string_literal: true

require "json_web_token/access_token"

class IssueTokenService < BaseService
  attr_accessor :username, :password

  def initialize(username, password)
    @username = username
    @password = password

    super(verified_user)
  end

  def run
    success(JSONWebToken::AccessToken.new(current_user).encoded_token)
  end

  private

  def verified_user
    user = User.find_by(username: username)

    raise ExceptionHandler::AuthenticationError, "Not authorized" unless user
    raise ExceptionHandler::AuthenticationError, "Invalid Credentials" unless user.valid_password?(password)

    user
  end
end
