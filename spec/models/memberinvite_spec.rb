require 'rails_helper'

RSpec.describe Memberinvite, type: :model do
  let(:memberinvite) { FactoryGirl.build(:memberinvite) }
  let(:invalid_memberinvite) { FactoryGirl.build(:invalid_memberinvite) }
  let(:invalid_email_memberinvite) { FactoryGirl.build(:invalid_email_memberinvite) }

  it { is_expected.to validate_presence_of(:email) }

  context "with a valid factory" do
    it "has a valid factory" do
      expect(memberinvite).to be_valid
    end

    it "generates a unique token" do
      token = memberinvite.generate_memberinvite_token
      newtoken = memberinvite.generate_memberinvite_token
      expect(newtoken).to_not eq(token)
    end
  end #valid factory context

  context "with an invalid factory" do
    it "has an invalid factory" do
      expect(invalid_memberinvite).not_to be_valid
    end

    it "is invalid without a 'valid' email" do
      expect(invalid_email_memberinvite).not_to be_valid
    end
  end #invalid factory context
end
