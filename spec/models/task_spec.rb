require "rails_helper"

RSpec.describe Task, type: :model do
  subject { create(:task) }

  it { is_expected.to validate_presence_of(:title) }
end
