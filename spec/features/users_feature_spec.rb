require 'rails_helper'
require 'support/controller_helpers'

feature "Can sign up a new user" do
  scenario "allows a user to sign up" do
    visit root_path

    click_link 'Sign Up'

    fill_in "Email", with: "tacoman@aol.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_link_or_button 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully'

  end
end