require 'rails_helper'
require 'support/controller_helpers'

feature "Can sign up a new user" do
  scenario "allows a user to sign up, and create an account" do
    visit root_path

    click_link 'Sign Up'

    # save_and_open_page

    fill_in "Subdomain", with: "mahsubdomain"
    fill_in "Email", with: "tacoman@aol.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    expect { click_button 'Sign up' }.to change(Account, :count).by(1)
    # click_link_or_button 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully'

    expect(User.find_by_email("tacoman@aol.com").account.subdomain).to eq("mahsubdomain")

    expect(Account.last.user.email).to eq("tacoman@aol.com")

  end
end