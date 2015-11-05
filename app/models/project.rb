class Project < ActiveRecord::Base

  default_scope { where(account_id: Account.current_id) }

  validates_presence_of :name

  belongs_to :account
  has_many :projects

  def self.current_id=(id)
    Thread.current[:project_id] = id
  end

  def self.current_id
    Thread.current[:project_id]
  end
end
