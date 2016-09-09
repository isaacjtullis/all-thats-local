require 'spec_helper'
#require 'rails_helper'

feature 'sign up', %Q{
  As an unathenticated user
  I want to sign up
  So that I can track my breakable toy
} do

  scenario 'specifying valid information and required information' do
    #user = FactoryGirl.create(:email)
    visit root_path
    click_link 'Sign Up'
    fill_in 'First Name', with: 'John'
    fill_in 'Last Name', with: 'Smith'
    fill_in 'Email', with: "testing@always.com"
  #why does this test fail if i don't update the password?
    fill_in 'user_password', with: 'password'
    fill_in 'Password Confirmation', with: 'password'
    click_button 'Sign Up'

    expect(page).to have_content("You're In!")
    expect(page).to have_content("Sign Out")
  end

  scenario 'required information is not supplied' do
    visit root_path
    click_link 'Sign Up'

    click_button 'Sign Up'

    expect(page).to have_content("can't be blank")
    expect(page).to_not have_content("Sign Out")
  end

  scenario 'password confirmation does not match configuration' do
    visit root_path
    click_link 'Sign Up'
    fill_in 'user_password', with: 'password'
    fill_in 'Password Confirmation', with: 'anotherpassword'

    click_button 'Sign Up'

    expect(page).to have_content("doesn't match")
    expect(page).to_not have_content("Sign Out")
  end
end
