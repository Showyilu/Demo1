require "rails_helper"

RSpec.describe User, type: :model do
  subject { create(:user) }

  it { is_expected.to validate_presence_of(:username) }
  it { is_expected.to validate_presence_of(:password_digest) }

  describe "passwords" do
    let!(:user) { create(:user, password: password_1) }
    let(:password_1) { "password_1" }
    let(:password_2) { "password_2" }

    it "password_digest should not be nil" do
      expect(user.password_digest).not_to be_nil
    end

    it "validates password correctly" do
      expect(user).to be_valid_password(password_1)
      expect(user).not_to be_valid_password(password_2)
    end
  end
end
