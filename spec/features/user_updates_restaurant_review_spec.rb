require 'pry'
require 'rails_helper'

feature 'user updates restaurant review', %Q{
  As a User
  I want to update my restaurant review
  So others can see new information
} do
  scenario 'User updates information' do
    user = FactoryGirl.create(:user)
    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    click_link 'Share Your Own Adventure'

    fill_in 'Name', with: "Garbanzo Delights"
    select('French', :from => 'Cusine')
    select('10', :from => 'Price')
    fill_in 'Review', with: 'Delicious!'
    click_button 'Post'

    click_link 'Edit'

    fill_in 'Name', with: "Lava Cake"
    select('French', :from => 'Cusine')
    select('10', :from => 'Price')
    fill_in 'Review', with: 'Delicious!'
    click_button 'Post'

    expect(page).to have_content("Lava Cake")
  end
end
