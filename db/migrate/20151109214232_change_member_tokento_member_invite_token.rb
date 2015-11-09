class ChangeMemberTokentoMemberInviteToken < ActiveRecord::Migration
  def change
    rename_column :memberinvites, :member_token, :memberinvite_token
  end
end
