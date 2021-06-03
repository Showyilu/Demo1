RSpec.describe IssueTokenService do
  subject(:service) { described_class.new(username, password_two) }

  let(:username) { user.username }
  let(:password) { "secure password" }
  let(:password_two) { "secure password" }
  let!(:user) { create(:user, password: password) }

  describe "#run" do
    let(:action) { service.run }

    it "is successful" do
      expect(action).to be_success
    end

    it "returns an access token" do
      expect(action.data).not_to be_nil
    end

    context "when invalid username" do
      let(:username) { "invalid" }

      it "raises an authentication error" do
        expect { action }.to raise_error(
          ExceptionHandler::AuthenticationError, /Not authorized/
        )
      end
    end

    context "when invalid password" do
      let(:password_two) { "invalid123" }

      it "raises an authentication error" do
        expect { action }.to raise_error(
          ExceptionHandler::AuthenticationError, /Invalid Credentials/
        )
      end
    end
  end
end
