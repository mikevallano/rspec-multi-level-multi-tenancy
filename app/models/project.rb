class Project < ActiveRecord::Base

  default_scope { where(account_id: Account.current_id) }

  validates_presence_of :name

  belongs_to :account
end
