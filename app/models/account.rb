class Account < ActiveRecord::Base

  validates_presence_of :subdomain

  belongs_to :user

  def self.current_id=(id)
    Thread.current[:account_id] = id
  end
end
