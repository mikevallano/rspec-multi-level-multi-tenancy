require 'rails_helper'

RSpec.describe Account, type: :model do
  let(:account) { FactoryGirl.build(:account) }
  let(:invalid_account) { FactoryGirl.build(:invalid_account) }

  context "With a valid account" do
    it "has a valid factory" do
      expect(account).to be_valid
    end

    it { is_expected.not_to validate_presence_of(:name) }

    it { is_expected.to validate_presence_of(:subdomain) }
  end #valid account context
end
