require 'rails_helper'

feature 'user signs in', %Q{
  As a User
  I want to sign in
  So that I can track my breakable toy
} do
  scenario 'an existing user specifies a valid email and password' do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link 'Sign In'

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Sign In'

    expect(page).to have_content("Welcome Back!")
    expect(page).to have_content("Sign Out")
  end

  scenario 'a nonexistant email and password is supplied' do
    visit root_path
    click_link 'Sign In'

    fill_in 'Email', with: 'nobody@example.com'
    fill_in 'Password', with: 'nopassword'
    click_button 'Sign In'

    expect(page).to_not have_content("Welcome Back!")
    expect(page).to_not have_content("Sign Out")
    expect(page).to have_content("Invalid Email or password")
  end

  scenario 'a existing email with the wrong password is denied access' do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link 'Sign In'

    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'incorrectPassword'
    click_button 'Sign In'

    expect(page).to have_content('Invalid Email or password')
  end

  scenario 'an already authorized user cannot re-sign in' do
    user = FactoryGirl.create(:user)
    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    expect(page).to have_content('Sign Out')
    expect(page).to_not have_content('Sign In')

    visit new_user_session_path
    #save_and_open_page # launch gemfile must be saved in order to use this
    expect(page).to have_content('You are already signed in.')

  end
end
