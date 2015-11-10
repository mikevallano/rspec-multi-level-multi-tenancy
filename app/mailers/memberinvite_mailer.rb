class MemberinviteMailer < ApplicationMailer

  def new_memberinvite(memberinvite)
    @memberinvite = memberinvite
    @sender = @memberinvite.sender.email
    @receiver = @memberinvite.email
    @link = new_user_registration_url(:memberinvite_token => @memberinvite.memberinvite_token)
    mail( :to => @receiver, :from => @sender,
      :subject => "You've been invited to the textit tester app" )
  end
end
