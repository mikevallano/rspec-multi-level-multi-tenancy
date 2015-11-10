require 'rails_helper'

feature "User can sign up/in and invite a user to manage their account" do

  before(:each) do
    reset_mailer
  end

  scenario "existing user can sign in and send a memberinvite" do
    switch_to_no_subdomain
    sign_in_user

    url = URI.parse(current_url)

    expect("#{url}").to eq("http://#{@subdomain}.lvh.me/")

    expect(page).to have_content("Signed in as: #{@email}")

    @account_id = Account.find_by_subdomain(@subdomain).id

    click_link "Invite a New Admin Member to this Account"
    fill_in 'Email', with: 'testyone@aol.com'

    expect { click_button 'Create Memberinvite' }.to change(Memberinvite.unscoped.where(account_id: @account_id), :count).by(1)
    expect(page).to have_content("successfully created")
    expect(last_email).to have_content("To: testyone@aol.com")
    expect(last_email.to).to eq(["testyone@aol.com"])
    expect(last_email.from).to eq([@current_user.email])


  end

end