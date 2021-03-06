# frozen_string_literal: true

module JSONWebToken
  class Token
    attr_accessor :issuer, :subject, :audience, :id
    attr_accessor :issued_at, :not_before, :expire_time

    DEFAULT_NOT_BEFORE_TIME = 5
    DEFAULT_EXPIRE_TIME = 60

    def initialize
      @id = SecureRandom.uuid
      @issued_at = Time.zone.now
      @not_before = issued_at - DEFAULT_NOT_BEFORE_TIME
      @expire_time = issued_at + DEFAULT_EXPIRE_TIME
      @custom_payload = {}
    end

    def [](key)
      @custom_payload[key]
    end

    def []=(key, value)
      @custom_payload[key] = value
    end

    def encoded
      raise NotImplementedError
    end

    def payload
      @custom_payload.merge(default_payload)
    end

    private

    def default_payload
      {
        jti: id,
        aud: audience,
        sub: subject,
        iss: issuer,
        iat: issued_at.to_i,
        nbf: not_before.to_i,
        exp: expire_time.to_i
      }.compact
    end
  end
end
