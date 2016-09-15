require 'rails_helper'

feature 'creates a restaurant', %Q{
  As an unathenticated user
  I want to create a restaurant review
} do

  scenario 'visitor cannot make a restaurant review until they are signed-in' do
    visit root_path
    click_link 'Share Your Own Adventure'

    expect(page).to have_content('You must be logged in to make changes!')
  end

  scenario 'User creates new review for restaurant' do
    user = FactoryGirl.create(:user)
    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    visit root_path
    click_link 'Share Your Own Adventure'

    fill_in 'Name', with: "Garbanzo Delights"
    select('French', :from => 'Cusine')
    select('10', :from => 'Price')
    fill_in 'Review', with: 'Delicious!'
    click_button 'Post'


    expect(page).to have_content("Garbanzo Delights")
    expect(page).to have_content("French")
    expect(page).to have_content("10")
    expect(page).to have_content("Delicious!")
  end

  scenario 'User can go back to home screen' do
    user = FactoryGirl.create(:user)
    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    visit root_path
    click_link 'Share Your Own Adventure'

    fill_in 'Name', with: "Garbanzo Delights"
    select('French', :from => 'Cusine')
    select('10', :from => 'Price')
    fill_in 'Review', with: 'Delicious!'
    click_button 'Post'

    visit root_path

    click_link "Share Your Own Adventure"

    click_link 'Back'

    expect(page).to have_content("Garbanzo Delights")
  end
end
