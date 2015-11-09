require 'rails_helper'

RSpec.describe Membership, type: :model do
  let(:membership) { FactoryGirl.build(:membership) }
  let(:invalid_membership) { FactoryGirl.build(:invalid_membership) }

  context "With a valid membership" do
    it "has a valid factory" do
      expect(membership).to be_valid
    end

    it { is_expected.to validate_presence_of(:user_id) }

    it { is_expected.to validate_presence_of(:account_id) }

    it { is_expected.to belong_to(:user) }

    it { is_expected.to belong_to(:account) }
  end #valid membership context

  context "with an invalid membership" do
    it "has an invalid factory" do
      expect(invalid_membership).to be_invalid
    end
  end #invalid membership context
end