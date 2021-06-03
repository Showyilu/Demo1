require "json_web_token/access_token"
require "json_web_token/hmac_token"

RSpec.describe AuthenticationService do
  subject(:service) { described_class.new(headers) }

  let(:user) { create(:user) }
  let(:headers) { ActionDispatch::Http::Headers.from_hash(useful_headers.stringify_keys) }
  let(:useful_headers) { { HTTP_AUTHORIZATION: token, HTTP_USERNAME: username }.compact }
  let(:username) { user.username }
  let(:token) { JSONWebToken::AccessToken.new(user).encoded_token }

  describe "#run" do
    subject(:action) { service.run }

    it { is_expected.to be_success }
    it { is_expected.to have_attributes(data: user) }

    context "with no token" do
      let(:token) { nil }

      it "raises a MissingToken error" do
        expect { action }.to raise_error(ExceptionHandler::MissingToken, "Missing Token")
      end
    end

    context "with fake token" do
      let(:token) { "fake token" }

      it "raises a InvalidToken error" do
        expect { action }.to raise_error(ExceptionHandler::InvalidToken, "Invalid Token")
      end
    end

    context "with expired token" do
      let(:token) do
        token = JSONWebToken::AccessToken.new(user).token
        token.expire_time = Time.zone.now - 1.hour
        token.encoded
      end

      it "raises a InvalidToken error with expired signature" do
        expect { action }.to raise_error(
          ExceptionHandler::InvalidToken,
          "Invalid Token"
        )
      end
    end
  end
end
