require 'rails_helper'

feature 'user deletes review', %Q{
  As a User
  I want to delete my review
  So others don't fall for my horrible review
} do
  scenario 'User must be logged in to delete a review' do
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
    visit root_path
    click_link 'Sign Out'

    visit root_path
    click_link 'Garbanzo Delights'
    click_link 'Delete'

    expect(page).to have_content("You must be logged in to make changes!")
  end

  scenario 'User deletes information' do
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

    click_link 'Delete'

    expect(page).to have_content("Review was deleted")
  end
end
