require 'rails_helper'

feature "User can sign up/in and invite a user to manage their account" do
  let(:receiver_email) { Faker::Internet.email }

  scenario "existing user can sign in and send a memberinvite" do
    switch_to_no_subdomain
    sign_in_user

    url = URI.parse(current_url)

    expect("#{url}").to eq("http://#{@subdomain}.lvh.me:3000/")

    expect(page).to have_content("Signed in as: #{@email}")

    @account_id = Account.find_by_subdomain(@subdomain).id

    click_link "Invite a New Admin Member to this Account"
    fill_in 'Email', with: receiver_email

    expect { click_button 'Create Memberinvite' }.to change(Memberinvite.unscoped.where(account_id: @account_id), :count).by(1)
    expect(page).to have_content("successfully created")
    expect(last_email).to have_content("To: #{receiver_email}")
    expect(last_email.to).to eq([receiver_email])
    expect(last_email.from).to eq([@current_user.email])
    expect(last_email.body.encoded).to include new_user_registration_path(:memberinvite_token =>
        Memberinvite.unscoped.where(account_id: @account_id).last.memberinvite_token)

    click_link "Sign Out"
    switch_to_no_subdomain
    visit new_user_registration_path(:memberinvite_token =>
        Memberinvite.unscoped.where(account_id: @account_id).last.memberinvite_token)

    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_link_or_button 'Sign up'

    expect(page).to have_content("You are now signed up!")

    click_link "Account Home Page"
    expect(page).to (have_content("#{@current_user.account.subdomain}"))
    save_and_open_page

  end

end