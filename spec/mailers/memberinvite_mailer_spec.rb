require "rails_helper"

RSpec.describe MemberinviteMailer, type: :mailer do

let(:user) { FactoryGirl.create(:user) }
let(:memberinvite) { FactoryGirl.create(:memberinvite, sender_id: user.id) }
let(:mail) { MemberinviteMailer.new_memberinvite(memberinvite) }

  describe "memberinvite mailer" do
    before(:each) do
      reset_mailer
    end

    it "sends user a memberinvite" do
      expect(mail.subject).to eq "You've been invited to the textit tester app"
      expect(mail.from).to eq [user.email]
      expect(mail.to).to eq [memberinvite.email]
      expect(mail.body.encoded).to include new_user_registration_url(:memberinvite_token => memberinvite.memberinvite_token)
    end
  end
end
