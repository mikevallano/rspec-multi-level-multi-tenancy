class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_initialize :set_account

  has_one :account
  accepts_nested_attributes_for :account



  def set_account
    build_account unless account.present?
  end
end
