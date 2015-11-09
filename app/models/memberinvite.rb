class Memberinvite < ActiveRecord::Base
  belongs_to :account
  belongs_to :sender, :class_name => 'User'
  belongs_to :receiver, :class_name => 'User'

  require 'securerandom'

  def generate_memberinvite_token
    SecureRandom.uuid + [Time.now.to_i, rand(100..1000)].join
  end

end
