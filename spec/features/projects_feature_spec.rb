require 'rails_helper'

feature "Can sign up a new user and account" do

  scenario "user can sign in, and is directed to their account subdomain" do
    switch_to_no_subdomain
    sign_in_user

    url = URI.parse(current_url)

    @account_id = Account.find_by_subdomain(@subdomain).id

    expect("#{url}").to eq("http://#{@subdomain}.lvh.me/")

    expect(page).to have_content("Signed in as: #{@email}")

    click_link "Projects"
    click_link "New Project"
    fill_in 'Name', with: 'test project one'
    # click_button 'Create Project'
    expect { click_button 'Create Project' }.to change(Project.unscoped, :count).by(1)
    # expect { click_button 'Create Project' }.to change(Project.where(account_id: @account_id), :count).by(1)
    # expect { click_button 'Create Task' }.to change(Task, :count).by(1)
    # change(Job.where(tenant_id: @tenant1.id),:count).by(1)
    expect(page).to have_content("Project was successfully created")

  end

  scenario "user can sign up and is directed to the welcome page on their account subdomain" do
    switch_to_no_subdomain
    sign_up_with("tacoface@aol.com", "password", "tacoface")

    url = URI.parse(current_url)

    expect("#{url}").to eq("http://#{@subdomain}.lvh.me/welcome")
  end

end