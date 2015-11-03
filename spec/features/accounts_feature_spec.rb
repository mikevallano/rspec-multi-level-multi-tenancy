require 'rails_helper'

feature "CRUD methods for accounts" do

  it "Allows users to sign up and create a account" do

    sign_up_with("tacotuesday@aol.com", "password")

    click_link "Accounts"
    click_link "New Account"
    fill_in 'Name', with: 'Looming account'
    fill_in 'Subdomain', with: 'looming'
    expect { click_button 'Create Account' }.to change(Account, :count).by(1)
    #user clicks Create Account button
    #account is successfully saved
  end

  it "Allows users to edit accounts" do

    sign_in_user

    click_link "Accounts"
    click_link "New Account"
    fill_in 'Name', with: 'Looming account'
    fill_in 'Subdomain', with: 'looming'
    click_button 'Create Account'

    expect(page).to have_content("Looming account")

    click_link "Edit"
    fill_in 'Name', with: 'Updated looming account'
    click_button "Update Account"

    expect(page).to have_content("successfully updated")


  end

end #allows creating a new account
