class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:account_home, :welcome]

  def home
  end

  def about
  end

  def account_home
  end

  def welcome
  end
end
