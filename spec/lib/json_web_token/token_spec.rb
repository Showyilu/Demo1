# frozen_string_literal: true

require "json_web_token/token"

RSpec.describe JSONWebToken::Token do
  let(:token) { described_class.new }

  context "custom payload" do
    let(:value) { "value" }

    before do
      token[:key] = value
    end

    it { expect(token[:key]).to eq(value) }
    it { expect(token.payload).to include(key: value) }
  end

  context "embeds default payload" do
    subject { token.payload }

    let(:default) { token.send(:default_payload) }

    it { is_expected.to include(default) }
  end
end
