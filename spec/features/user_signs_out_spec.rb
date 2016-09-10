require 'rails_helper'

feature 'user signs out', %Q{
  As a User
  I want to sign out
  So others cannot post for me
} do

  scenario 'I want to be able to log out of my session' do
    user = FactoryGirl.create(:user)
    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    visit root_path
    click_link "Sign Out"

    expect(page).to have_content('Sign In')
    expect(page).to_not have_content('Sign Out')
  end

  scenario 'A user can log in, log out and successfully log in' do
    user = FactoryGirl.create(:user)
    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    visit root_path
    click_link "Sign Out"

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    expect(page).to have_content('Sign Out')
    expect(page).to_not have_content('Sign In')
  end
end
