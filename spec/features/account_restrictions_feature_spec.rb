require 'rails_helper'

feature "User can not access other users' accounts" do

  scenario "user is redirected to their homepage if they access another user's account" do
    switch_to_no_subdomain
    sign_in_user

    url = URI.parse(current_url)

    expect("#{url}").to eq("http://#{@subdomain}.lvh.me/")

    expect(page).to have_content("Signed in as: #{@email}")

    account2 = FactoryGirl.create(:account, subdomain: "notmine")

    visit("http://notmine.lvh.me/welcome")
    expect(page).to have_content("You are not part of that account")
    expect("#{url}").to eq("http://#{@subdomain}.lvh.me/")

  end

end