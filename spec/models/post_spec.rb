require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { FactoryGirl.build(:post) }
  let(:invalid_post) { FactoryGirl.build(:invalid_post) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.not_to validate_presence_of(:description) }

  context "with a valid factory" do
    it "has a valid factory" do
      expect(post).to be_valid
    end

    it { is_expected.to belong_to(:project) }

    it "belongs to a project" do
      expect(post.project).not_to be nil
    end

  end #valid factory context

  context "with an invalid factory" do
    it "has an invalid factory" do
      expect(invalid_post).not_to be_valid
    end
  end #invalid factory context
end
