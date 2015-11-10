require 'rails_helper'

feature "User can sign up/in and add projects to their account" do

  scenario "existing user can sign in and create projects" do
    switch_to_no_subdomain
    sign_in_user

    url = URI.parse(current_url)

    expect("#{url}").to eq("http://#{@subdomain}.lvh.me:3000/")

    expect(page).to have_content("Signed in as: #{@email}")

    @account_id = Account.find_by_subdomain(@subdomain).id

    click_link "Projects"
    click_link "New Project"
    fill_in 'Name', with: 'test project one'
    expect { click_button 'Create Project' }.to change(Project.unscoped.where(account_id: @account_id), :count).by(1)
    expect(page).to have_content("Project was successfully created")

  end

  scenario "user can sign up and is directed to the welcome page on their account subdomain" do
    switch_to_no_subdomain
    sign_up_with("tacoface@aol.com", "password", "tacoface")

    url = URI.parse(current_url)

    expect("#{url}").to eq("http://#{@subdomain}.lvh.me:3000/welcome")

    @account_id = Account.find_by_subdomain(@subdomain).id

    click_link "Projects"
    click_link "New Project"
    fill_in 'Name', with: 'test project one'
    expect { click_button 'Create Project' }.to change(Project.unscoped.where(account_id: @account_id), :count).by(1)
    expect(page).to have_content("Project was successfully created")
  end

end