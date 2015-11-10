require "rails_helper"

RSpec.describe MemberinviteMailer, type: :mailer do

let(:user) { FactoryGirl.create(:user) }
let(:memberinvite) { FactoryGirl.create(:memberinvite) }
# let(:memberinvite_url) { "#{user.account.subdomain}.lvh.me:300/users/sign_up?#{memberinvite.memberinvite_token}" }
let(:mail) { MemberinviteMailer.new_memberinvite(memberinvite, memberinvite_url) }

  describe "memberinvite mailer" do
    before(:each) do
      reset_mailer
    end

    it "sends user a memberinvite" do
      binding.pry
      expect(mail.subject).to eq "You've been invited to the textit tester app"
      expect(mail.from).to eq [user.email]
      expect(mail.to).to eq [memberinvite.email]
      # expect(mail.body.encoded).to match edit_friendship_url(user, friend)
    end
  end
end
