module FeatureHelpers
  def sign_up_with(email, password, subdomain)
    visit root_path

    click_link 'Sign Up'

    fill_in "Subdomain", with: subdomain
    fill_in "Email", with: email
    fill_in "Password", with: password
    fill_in "Password confirmation", with: password
    click_link_or_button 'Sign up'
    @subdomain = subdomain
    @email = email
  end

  def sign_in_user
    user = FactoryGirl.create(:user)
    @subdomain = user.account.subdomain
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end

end