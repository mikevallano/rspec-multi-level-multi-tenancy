class Membership < ActiveRecord::Base

  validates_presence_of :user_id
  validates_presence_of :account_id

  belongs_to :user
  belongs_to :account
end
