class Account < ActiveRecord::Base

  validates_presence_of :subdomain
end
