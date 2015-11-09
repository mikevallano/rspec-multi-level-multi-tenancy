class Account < ActiveRecord::Base

  validates_presence_of :subdomain

  belongs_to :user
  has_many :projects

  has_many :memberships
  has_many :associated_users, :through => :memberships,
    :source => :user,
    :foreign_key => 'user_id'

  def self.current_id=(id)
    Thread.current[:account_id] = id
  end

  def self.current_id
    Thread.current[:account_id]
  end
end
