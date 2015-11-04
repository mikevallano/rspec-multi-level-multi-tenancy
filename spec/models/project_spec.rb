require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:project) { FactoryGirl.build(:project) }
  let(:invalid_project) { FactoryGirl.build(:invalid_project) }


  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.not_to validate_presence_of(:description) }


  context "with a valid project" do
    it "has a valid factory" do
      expect(project).to be_valid
    end

    it { is_expected.to belong_to(:account) }

    it "is belongs to an account" do
      expect(project.account.subdomain).not_to be nil
    end

  end #valid project context

  context "with an invalid project" do
    it "has an invalid project" do
      expect(invalid_project).not_to be_valid
    end

    it "is invalid without a name" do
      expect(invalid_project.name).to be nil
    end
  end #invalid project context
end #final ender
