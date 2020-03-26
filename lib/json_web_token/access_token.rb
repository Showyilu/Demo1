# frozen_string_literal: true

require "json_web_token/hmac_token"

module JSONWebToken
  class AccessToken
    DEFAULT_EXPIRE_TIME = 86400

    attr_accessor :user

    def initialize(user)
      @user = user
    end

    def token
      hmac_token = JSONWebToken::HMACToken.new(self.class.secret)
      hmac_token.expire_time = Time.zone.now + DEFAULT_EXPIRE_TIME
      hmac_token[:data] = { user_id: user.id, username: user.username }
      hmac_token
    end

    def encoded_token
      token.encoded
    end

    def self.decoded_token(token_to_decode)
      JSONWebToken::HMACToken.decode(token_to_decode, secret).first
    end

    def self.secret
      Rails.application.credentials.secret_key_base
    end
  end
end
