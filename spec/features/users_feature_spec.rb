require 'rails_helper'
require 'support/controller_helpers'

feature "Can sign up a new user and account" do

  scenario "allows using subdomain helpers and sign_in_user" do
    switch_to_no_subdomain
    sign_in_user

    url = URI.parse(current_url)

    expect("#{url}").to eq("http://#{@subdomain}.lvh.me/")

  end

  scenario "allows using subdomain helpers and sign up user" do
    switch_to_no_subdomain
    sign_up_with("tacoface@aol.com", "password", "tacoface")

    url = URI.parse(current_url)

    expect("#{url}").to eq("http://#{@subdomain}.lvh.me/welcome")
  end

end