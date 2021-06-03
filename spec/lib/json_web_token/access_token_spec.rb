# frozen_string_literal: true

require "json_web_token/access_token"

RSpec.describe JSONWebToken::AccessToken do
  subject(:access_token) { described_class.new(user) }

  let(:user) { create(:user) }

  describe "#token" do
    subject(:token) { access_token.token }

    it "contains 'user_id' in payload" do
      expect(token[:data]).to include(user_id: user.id)
    end

    it "contains 'username' in payload" do
      expect(token[:data]).to include(username: user.username)
    end
  end

  describe ".decoded_token" do
    subject(:decoded_token) { described_class.decoded_token(token.encoded) }

    let(:token) { access_token.token }
    let(:token_payload) { token.payload.deep_stringify_keys }

    it "decodes token correctly" do
      expect(decoded_token).to include(token_payload)
    end
  end
end
